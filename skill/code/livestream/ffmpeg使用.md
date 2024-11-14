```shell
ffmpeg -f gdigrab -i desktop -r 30 -c:v libx264 -preset veryfast -maxrate 1000k -bufsize 2000k -pix_fmt yuv420p -g 50 -c:a aac -b:a 160k -ar 44100 -ac 2 -s 640x360 -f flv rtmp://127.0.0.1:10035/live/stream -s 1920x1080 -f mp4 -y out.mp4
```

录制桌面内容，既保存为本地mp4文件的同时，也进行推流操作


https://stackoverflow.com/questions/72884815/how-to-stream-frames-from-opencv-c-code-to-video4linux-or-ffmpeg

https://www.nobile-engineering.com/wordpress/index.php/2018/10/26/opencv-streaming-ffmpeg/


```shell
ffmpeg -f gdigrab -i desktop -r 24 -c:v libx264 -preset veryfast -maxrate 1000k -bufsize 2000k -pix_fmt yuv420p -g 50 -c:a aac -b:a 160k -ar 44100 -ac 2 -s 1920x1080 -f flv rtmp://127.0.0.1:10035/live/asdfhgjkasduifasdf678asdfhjk
```

```shell
ffmpeg -f gdigrab -i desktop -r 24 -c:v libx264 -preset veryfast -maxrate 1000k -bufsize 2000k -pix_fmt yuv420p -g 50 -c:a aac -b:a 160k -ar 44100 -ac 2 -s 1280x720 -aspect 48:9 -f flv rtmp://127.0.0.1:10035/live/2
```

```shell
..\..\..\..\..\..\Dev\OpenZIProj\onionfiredrill-daodiao\Plugins\OnionUI\Resources\Recorder\ffmpeg.exe -f gdigrab -i desktop -r 24 -c:v libx264 -preset veryfast -maxrate 1000k -bufsize 2000k -pix_fmt yuv420p -g 50 -c:a aac -b:a 160k -ar 44100 -ac 2 -s 1280x720 -aspect 48:9 -f flv rtmp://127.0.0.1:10035/live/76797cd021b2e0cf8d26f0375ba3ba7d
```


## 问题

当使用ffmpeg录屏/推流时，steamvr会出现反复崩溃重启的问题，应该是两者不兼容，改用obs进行录屏/推流可以解决此问题

