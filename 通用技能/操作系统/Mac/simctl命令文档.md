#mac 
honey@honey bin % ./simctl --help

usage: simctl [--set <path>] [--profiles <path>] <subcommand> ...

   simctl help [subcommand]

Command line utility to control the Simulator

For subcommands that require a <device> argument, you may specify a device UDID

or the special "booted" string which will cause simctl to pick a booted device.

If multiple devices are booted when the "booted" device is selected, simctl

will choose one of them.

Subcommands:

addmedia            Add photos, live photos, videos, or contacts to the library of a device.

boot                Boot a device or device pair.

clone               Clone an existing device.

create              Create a new device.

delete              Delete specified devices, unavailable devices, or all devices.

diagnose            Collect diagnostic information and logs.

erase               Erase a device's contents and settings.

get_app_container   Print the path of the installed app's container

getenv              Print an environment variable from a running device.

help                Prints the usage for a given subcommand.

icloud_sync         Trigger iCloud sync on a device.

install             Install an app on a device.

install_app_data    Install an xcappdata package to a device, replacing the current contents of the container.

io                  Set up a device IO operation.

keychain            Manipulate a device's keychain

launch              Launch an application by identifier on a device.

list                List available devices, device types, runtimes, or device pairs.

location            Control a device's simulated location

logverbose          enable or disable verbose logging for a device

openurl             Open a URL in a device.

pair                Create a new watch and phone pair.

pair_activate       Set a given pair as active.

pbcopy              Copy standard input onto the device pasteboard.

pbpaste             Print the contents of the device's pasteboard to standard output.

pbsync              Sync the pasteboard content from one pasteboard to another.

privacy             Grant, revoke, or reset privacy and permissions

push                Send a simulated push notification

rename              Rename a device.

runtime             Perform operations on runtimes

shutdown            Shutdown a device.

spawn               Spawn a process by executing a given executable on a device.

status_bar          Set or clear status bar overrides

terminate           Terminate an application by identifier on a device.

ui                  Get or Set UI options

uninstall           Uninstall an app from a device.

unpair              Unpair a watch and phone pair.

upgrade             Upgrade a device to a newer runtime.