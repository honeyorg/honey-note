#ue #bug #vehicle

移动组件使用的是`UChaosVehicleMovementComponent`。

ForwardSpeed由以下两个函数进行赋值

```c++
void FVehicleState::CaptureState(const FBodyInstance* TargetInstance, float GravityZ, float DeltaTime)
{
	if (TargetInstance)
	{

		VehicleWorldTransform = TargetInstance->GetUnrealWorldTransform();
		VehicleWorldVelocity = TargetInstance->GetUnrealWorldVelocity();
		VehicleWorldAngularVelocity = TargetInstance->GetUnrealWorldAngularVelocityInRadians();
		VehicleWorldCOM = TargetInstance->GetCOMPosition();
		WorldVelocityNormal = VehicleWorldVelocity.GetSafeNormal();

		VehicleUpAxis = VehicleWorldTransform.GetUnitAxis(EAxis::Z);
		VehicleForwardAxis = VehicleWorldTransform.GetUnitAxis(EAxis::X);
		VehicleRightAxis = VehicleWorldTransform.GetUnitAxis(EAxis::Y);

		VehicleLocalVelocity = VehicleWorldTransform.InverseTransformVector(VehicleWorldVelocity);
		LocalAcceleration = (VehicleLocalVelocity - LastFrameVehicleLocalVelocity) / DeltaTime;
		LocalGForce = LocalAcceleration / FMath::Abs(GravityZ);
		LastFrameVehicleLocalVelocity = VehicleLocalVelocity;

		ForwardSpeed = FVector::DotProduct(VehicleWorldVelocity, VehicleForwardAxis);
		ForwardsAcceleration = LocalAcceleration.X;
	}
}

void FVehicleState::CaptureState(const Chaos::FRigidBodyHandle_Internal* Handle, float GravityZ, float DeltaTime)
{
	if (Handle)
	{
		const FTransform WorldTM(Handle->R(), Handle->X());
		VehicleWorldTransform = WorldTM;
		VehicleWorldVelocity = Handle->V();
		VehicleWorldAngularVelocity = Handle->W();
		VehicleWorldCOM = Handle->CenterOfMass();
		WorldVelocityNormal = VehicleWorldVelocity.GetSafeNormal();

		VehicleUpAxis = VehicleWorldTransform.GetUnitAxis(EAxis::Z);
		VehicleForwardAxis = VehicleWorldTransform.GetUnitAxis(EAxis::X);
		VehicleRightAxis = VehicleWorldTransform.GetUnitAxis(EAxis::Y);

		VehicleLocalVelocity = VehicleWorldTransform.InverseTransformVector(VehicleWorldVelocity);
		LocalAcceleration = (VehicleLocalVelocity - LastFrameVehicleLocalVelocity) / DeltaTime;
		LocalGForce = LocalAcceleration / FMath::Abs(GravityZ);

#if !(UE_BUILD_SHIPPING || UE_BUILD_TEST)
		if (Chaos::FPhysicsSolverBase::IsNetworkPhysicsPredictionEnabled() && Chaos::FPhysicsSolverBase::CanDebugNetworkPhysicsPrediction())
		{
			UE_LOG(LogVehicle, Log, TEXT("Vehicle state last velocity = %s | World Transform = %s | World Velocity = %s"),
				*LastFrameVehicleLocalVelocity.ToString(), *VehicleWorldTransform.ToString(), *VehicleWorldVelocity.ToString());
		}
#endif
		LastFrameVehicleLocalVelocity = VehicleLocalVelocity;

		ForwardSpeed = FVector::DotProduct(VehicleWorldVelocity, VehicleForwardAxis);
		ForwardsAcceleration = LocalAcceleration.X;


	}
}
```

这两个函数的调用是在以下几个地方

```c++
void UChaosVehicleSimulation::UpdateState(float DeltaTime, const FChaosVehicleAsyncInput& InputData, Chaos::FRigidBodyHandle_Internal* Handle)
{
	VehicleState.CaptureState(Handle, InputData.PhysicsInputs.GravityZ, DeltaTime);
}

void UChaosVehicleMovementComponent::UpdateState(float DeltaTime)
{
	// update input values
	AController* Controller = GetController();
	VehicleState.CaptureState(GetBodyInstance(), GetGravityZ(), DeltaTime);
	VehicleState.NumWheelsOnGround = 0;
	VehicleState.bVehicleInAir = false;
	int NumWheels = 0;
	if (PVehicleOutput)
	{
		for (int WheelIdx = 0; WheelIdx < PVehicleOutput->Wheels.Num(); WheelIdx++)
		{
			if (PVehicleOutput->Wheels[WheelIdx].InContact)
			{
				VehicleState.NumWheelsOnGround++;
			}
			else
			{
				VehicleState.bVehicleInAir = true;
			}
			NumWheels++;
		}
	}
	VehicleState.bAllWheelsOnGround = (VehicleState.NumWheelsOnGround == NumWheels);

	bool bProcessLocally = bRequiresControllerForInputs ? (Controller && Controller->IsLocalController()) : true;

	// IsLocallyControlled will fail if the owner is unpossessed (i.e. Controller == nullptr);
	// Should we remove input instead of relying on replicated state in that case?
	if (bProcessLocally && PVehicleOutput)
	{
		if (bReverseAsBrake)
		{
			//for reverse as state we want to automatically shift between reverse and first gear
			// Note: Removed this condition to support wheel spinning when rolling backwards with accelerator pressed, rather than braking
			//if (FMath::Abs(GetForwardSpeed()) < WrongDirectionThreshold)	//we only shift between reverse and first if the car is slow enough.
			{
				if (RawBrakeInput > KINDA_SMALL_NUMBER && GetCurrentGear() >= 0 && GetTargetGear() >= 0)
				{
					SetTargetGear(-1, true);
				}
				else if (RawThrottleInput > KINDA_SMALL_NUMBER && GetCurrentGear() <= 0 && GetTargetGear() <= 0)
				{
					SetTargetGear(1, true);
				}
			}
		}
		else
		{
			if (TransmissionType == Chaos::ETransmissionType::Automatic)
			{
				if (RawThrottleInput > KINDA_SMALL_NUMBER
					&& GetCurrentGear() == 0
					&& GetTargetGear() == 0)
				{
					SetTargetGear(1, true);
				}
			}

		}

		float ModifiedThrottle = 0.f;
		float ModifiedBrake = 0.f;
		CalcThrottleBrakeInput(ModifiedThrottle, ModifiedBrake);

		// Apply Inputs locally
		SteeringInput = SteeringInputRate.InterpInputValue(DeltaTime, SteeringInput, CalcSteeringInput());
		ThrottleInput = ThrottleInputRate.InterpInputValue(DeltaTime, ThrottleInput, ModifiedThrottle);
		BrakeInput = BrakeInputRate.InterpInputValue(DeltaTime, BrakeInput, ModifiedBrake);
		PitchInput = PitchInputRate.InterpInputValue(DeltaTime, PitchInput, CalcPitchInput());
		RollInput = RollInputRate.InterpInputValue(DeltaTime, RollInput, CalcRollInput());
		YawInput = YawInputRate.InterpInputValue(DeltaTime, YawInput, CalcYawInput());
		HandbrakeInput = HandbrakeInputRate.InterpInputValue(DeltaTime, HandbrakeInput, CalcHandbrakeInput());

		if (!bUsingNetworkPhysicsPrediction)
		{
			// and send to server - (ServerUpdateState_Implementation below)
			ServerUpdateState(SteeringInput, ThrottleInput, BrakeInput, HandbrakeInput, GetCurrentGear(), RollInput, PitchInput, YawInput);
		}

		if (PawnOwner && PawnOwner->IsNetMode(NM_Client))
		{
			MarkForClientCameraUpdate();
		}
	}
	else if (!bUsingNetworkPhysicsPrediction)
	{
		// use replicated values for remote pawns
		SteeringInput = ReplicatedState.SteeringInput;
		ThrottleInput = ReplicatedState.ThrottleInput;
		BrakeInput = ReplicatedState.BrakeInput;
		PitchInput = ReplicatedState.PitchInput;
		RollInput = ReplicatedState.RollInput;
		YawInput = ReplicatedState.YawInput;
		HandbrakeInput = ReplicatedState.HandbrakeInput;
		SetTargetGear(ReplicatedState.TargetGear, true);
	}
}
```


按键`油门`，`手刹`，`启动`是`通用车SDK按键`分类下的。查阅代码发现在这里注册的

```c++
// CarLogicTranslator.cpp
void FCarLogicTranslator::RegisterSystemKey()
{
	//注册Input分类
	EKeys::AddMenuCategoryDisplayInfo(InputKey_Category, LOCTEXT("CarSDKWrapper", "通用车SDK按键"),
		TEXT("GraphEditor.PadEvent_16x"));

	for (auto config : CarSDKWrapperKeys::Config)
	{
		//添加系统按键
		EKeys::AddKey(FKeyDetails(config.InputKey, config.DisplayName, config.KeyFlag, InputKey_Category));
	}
	UE_LOG(LogTemp, Warning, TEXT("RegisterSystemKeys"));
}
```

其中的`CarSDKWrapperKeys::Config`在这里赋值的

```c++
// CarSDKWrapperController.h
//按键定义
namespace CarSDKWrapperKeys
{
	//方向盘
	const FKey CommonCar_SDK_Wheel("CarSDKWrapper_Wheel");
	//油门
	const FKey CommonCar_SDK_Throttle("CarSDKWrapper_Throttle");
	//刹车
	const FKey CommonCar_SDK_Braking("CarSDKWrapper_Braking");
	//手刹
	const FKey CommonCar_SDK_HandBraker("CarSDKWrapper_HandBraker");
	//启动
	const FKey CommonCar_SDK_Active("CarSDKWrapper_Active");
	//转向灯关闭
	const FKey CommonCar_SDK_TurnLightTurnOff("CarSDKWrapper_TurnLightTurnOf");
	//左转向灯
	const FKey CommonCar_SDK_TurnLightLeft("CarSDKWrapper_TurnLightLeft");
	//右转向灯
	const FKey CommonCar_SDK_TurnLightRight("CarSDKWrapper_TurnLight");
	//远光灯
	const FKey CommonCar_SDK_BeamsLight("CarSDKWrapper_BeamLight");
	//近光灯
	const FKey CommonCar_SDK_LowBeamsLight("CarSDKWrapper_LowBeamLight");
	//应急灯
	const FKey CommonCar_SDK_EmergencyLight("CarSDKWrapper_EmergencyLight");
	//喇叭
	const FKey CommonCar_SDK_Horn("CarSDKWrapper_Horn");
	//安全带
	const FKey CommonCar_SDK_SafelyBelt("CarSDKWrapper_SafelyBelt");
	//雨刮器开关
	const FKey CommonCar_SDK_WindscreenWiper("CarSDKWrapper_WindScreenWiper");
	//雨刮器速度
	const FKey CommonCar_SDK_WindscreenWiperSpeed("CarSDKWrapper_WindScreenWiperSpeed");
	//示廓灯
	const FKey CommonCar_SDK_OutlineMarkerLamps("CarSDKWrapper_OutlineMarkerLamps");
	//前雾灯
	const FKey CommonCar_SDK_FrontFogLight("CarSDKWrapper_FrontFogLight");
	//后雾灯
	const FKey CommonCar_SDK_BackFogLight("CarSDKWrapper_BackFogLight");
	//大灯高度调节
	const FKey CommonCar_SDK_LightBeamHeight("CarSDKWrapper_LightBeamHeight");
	//档位（D档、N档、P档、R档）
	const FKey CommonCar_SDK_Gear("CarSDKWrapper_Gear");

	struct FKeyConfig
	{
	public:
		FKeyConfig(FKey Key, FText Name, uint32 Flag):
			InputKey(Key),DisplayName(Name), KeyFlag(Flag)
		{
			
		}

		FKey   InputKey;
		FText  DisplayName;
		uint32 KeyFlag;
	};
	
	const TArray<FKeyConfig> Config = {
#define LOCTEXT_NAMESPACE "FCarSDKWrapperCarLogic"
		FKeyConfig(CommonCar_SDK_Wheel, LOCTEXT("DriveWheel", "方向盘"), FKeyDetails::Axis1D),
		FKeyConfig(CommonCar_SDK_Throttle, LOCTEXT("Throttle", "油门"), FKeyDetails::Axis1D),
		FKeyConfig(CommonCar_SDK_Braking, LOCTEXT("Braking", "刹车"), FKeyDetails::Axis1D),
		FKeyConfig(CommonCar_SDK_HandBraker, LOCTEXT("HandBraker", "手刹"), FKeyDetails::GamepadKey),
		FKeyConfig(CommonCar_SDK_Active, LOCTEXT("CarSDK_Active", "启动"), FKeyDetails::GamepadKey),
		FKeyConfig(CommonCar_SDK_TurnLightTurnOff, LOCTEXT("TurnLightTurnOff", "转向灯关闭"), FKeyDetails::GamepadKey),
		FKeyConfig(CommonCar_SDK_TurnLightLeft, LOCTEXT("TurnLightLeft", "左转向灯"), FKeyDetails::GamepadKey),
		FKeyConfig(CommonCar_SDK_TurnLightRight, LOCTEXT("TurnLightRight", "右转向灯"), FKeyDetails::GamepadKey),
		FKeyConfig(CommonCar_SDK_BeamsLight, LOCTEXT("BeamsLight", "远光灯"), FKeyDetails::GamepadKey),
		FKeyConfig(CommonCar_SDK_LowBeamsLight, LOCTEXT("LowBeamsLight", "近光灯"), FKeyDetails::GamepadKey),
		FKeyConfig(CommonCar_SDK_EmergencyLight, LOCTEXT("EmergencyLight", "应急灯"), FKeyDetails::GamepadKey),
		FKeyConfig(CommonCar_SDK_Horn, LOCTEXT("Horn", "喇叭"), FKeyDetails::GamepadKey),
		FKeyConfig(CommonCar_SDK_SafelyBelt, LOCTEXT("SafetyBelt", "安全带"), FKeyDetails::GamepadKey),
		FKeyConfig(CommonCar_SDK_WindscreenWiper, LOCTEXT("WindscreenWiper", "雨刮器开关"), FKeyDetails::GamepadKey),
		FKeyConfig(CommonCar_SDK_WindscreenWiperSpeed, LOCTEXT("WindscreenWiperSpeed", "雨刮器档位"), FKeyDetails::Axis1D),
		FKeyConfig(CommonCar_SDK_OutlineMarkerLamps, LOCTEXT("OutlineMarkerLamps", "示廓灯"), FKeyDetails::GamepadKey),
		FKeyConfig(CommonCar_SDK_FrontFogLight, LOCTEXT("FogLight_Front", "前雾灯"), FKeyDetails::GamepadKey),
		FKeyConfig(CommonCar_SDK_BackFogLight, LOCTEXT("FogLight_Back", "后雾灯"), FKeyDetails::GamepadKey),
		FKeyConfig(CommonCar_SDK_LightBeamHeight, LOCTEXT("LightBeamHeight", "大灯高度调节"), FKeyDetails::Axis1D),
		FKeyConfig(CommonCar_SDK_Gear, LOCTEXT("Gear", "档位"), FKeyDetails::Axis1D),
#undef LOCTEXT_NAMESPACE
	};

}

```

