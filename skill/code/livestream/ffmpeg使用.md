```shell
ffmpeg -f gdigrab -i desktop -framerate 30 -c:v libx264 -preset veryfast -maxrate 1000k -bufsize 2000k -pix_fmt yuv420p -g 50 -c:a aac -b:a 160k -ar 44100 -ac 2
 -s 640x360 -f flv rtmp://127.0.0.1:10035/live/stream -s 1920x1080 -f mp4 -y out.mp4
```

录制桌面内容，既保存为本地mp4文件的同时，也进行推流操作

