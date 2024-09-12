查询端口情况
`lsof -i :port`
`netstat -tulnp | grep :port`

查询sh脚本
`ps aux | grep script.sh`

webrtc状态说明：[参考链接](https://zhuanlan.zhihu.com/p/536769174)

webrtc防火墙规则：[参考链接](https://wenku.baidu.com/view/5c13c07c49fe04a1b0717fd5360cba1aa8118ca1.html?_wkts_=1724936848959&bdQuery=webrtc%E6%89%80%E9%9C%80%E7%9A%84%E7%AB%AF%E5%8F%A3%E5%92%8C%E5%8D%8F%E8%AE%AE%E9%83%BD%E6%9C%89%E5%93%AA%E4%BA%9B%3F%E6%88%91%E5%BA%94%E8%AF%A5%E6%80%8E%E4%B9%88%E5%BC%80%E9%98%B2%E7%81%AB%E5%A2%99)

可能是因为没有开udp的权限

‌**[WebRTC](https://www.baidu.com/s?sa=re_dqa_generate&wd=WebRTC&rsv_pq=d1a1d2060000fcf7&oq=webrtc%20ice%E5%8D%A1%E5%9C%A8%E4%BA%86connectionchecking&rsv_t=d69aQ6BVZykF9rTGlxTjhJl2XQHOkXwTuihObstR0u2w4m9ZctlTcdV6aH9pXzccNHf4dRI0SwA&tn=58025142_4_oem_dg&ie=utf-8)的[ICE连接状态](https://www.baidu.com/s?sa=re_dqa_generate&wd=ICE%E8%BF%9E%E6%8E%A5%E7%8A%B6%E6%80%81&rsv_pq=d1a1d2060000fcf7&oq=webrtc%20ice%E5%8D%A1%E5%9C%A8%E4%BA%86connectionchecking&rsv_t=d69aQ6BVZykF9rTGlxTjhJl2XQHOkXwTuihObstR0u2w4m9ZctlTcdV6aH9pXzccNHf4dRI0SwA&tn=58025142_4_oem_dg&ie=utf-8)卡在"checking"状态**‌通常意味着[ICE协议](https://www.baidu.com/s?sa=re_dqa_generate&wd=ICE%E5%8D%8F%E8%AE%AE&rsv_pq=d1a1d2060000fcf7&oq=webrtc%20ice%E5%8D%A1%E5%9C%A8%E4%BA%86connectionchecking&rsv_t=d69aQ6BVZykF9rTGlxTjhJl2XQHOkXwTuihObstR0u2w4m9ZctlTcdV6aH9pXzccNHf4dRI0SwA&tn=58025142_4_oem_dg&ie=utf-8)正在尝试建立连接，但尚未成功。这种情况可能由多种原因引起，包括网络问题、[信令服务器](https://www.baidu.com/s?sa=re_dqa_generate&wd=%E4%BF%A1%E4%BB%A4%E6%9C%8D%E5%8A%A1%E5%99%A8&rsv_pq=d1a1d2060000fcf7&oq=webrtc%20ice%E5%8D%A1%E5%9C%A8%E4%BA%86connectionchecking&rsv_t=d69aQ6BVZykF9rTGlxTjhJl2XQHOkXwTuihObstR0u2w4m9ZctlTcdV6aH9pXzccNHf4dRI0SwA&tn=58025142_4_oem_dg&ie=utf-8)问题、[权限问题](https://www.baidu.com/s?sa=re_dqa_generate&wd=%E6%9D%83%E9%99%90%E9%97%AE%E9%A2%98&rsv_pq=d1a1d2060000fcf7&oq=webrtc%20ice%E5%8D%A1%E5%9C%A8%E4%BA%86connectionchecking&rsv_t=d69aQ6BVZykF9rTGlxTjhJl2XQHOkXwTuihObstR0u2w4m9ZctlTcdV6aH9pXzccNHf4dRI0SwA&tn=58025142_4_oem_dg&ie=utf-8)或[ICE服务器](https://www.baidu.com/s?sa=re_dqa_generate&wd=ICE%E6%9C%8D%E5%8A%A1%E5%99%A8&rsv_pq=d1a1d2060000fcf7&oq=webrtc%20ice%E5%8D%A1%E5%9C%A8%E4%BA%86connectionchecking&rsv_t=d69aQ6BVZykF9rTGlxTjhJl2XQHOkXwTuihObstR0u2w4m9ZctlTcdV6aH9pXzccNHf4dRI0SwA&tn=58025142_4_oem_dg&ie=utf-8)配置问题等。解决这一问题需要从以下几个方面进行排查和处理：

1. ‌**检查网络连接**‌：确保客户端和服务器之间的网络连接稳定，没有丢包或延迟过高的问题。
2. ‌**检查信令服务器**‌：信令服务器负责在两端之间传递信息，确保信令服务器正常运行，能够正确传递[STUN](https://www.baidu.com/s?sa=re_dqa_generate&wd=STUN&rsv_pq=d1a1d2060000fcf7&oq=webrtc%20ice%E5%8D%A1%E5%9C%A8%E4%BA%86connectionchecking&rsv_t=d69aQ6BVZykF9rTGlxTjhJl2XQHOkXwTuihObstR0u2w4m9ZctlTcdV6aH9pXzccNHf4dRI0SwA&tn=58025142_4_oem_dg&ie=utf-8)和[TURN](https://www.baidu.com/s?sa=re_dqa_generate&wd=TURN&rsv_pq=d1a1d2060000fcf7&oq=webrtc%20ice%E5%8D%A1%E5%9C%A8%E4%BA%86connectionchecking&rsv_t=d69aQ6BVZykF9rTGlxTjhJl2XQHOkXwTuihObstR0u2w4m9ZctlTcdV6aH9pXzccNHf4dRI0SwA&tn=58025142_4_oem_dg&ie=utf-8)服务器的信息。
3. ‌**检查权限**‌：确保客户端有正确的权限访问网络和媒体资源。
4. ‌**检查ICE服务器配置**‌：[ICE配置](https://www.baidu.com/s?sa=re_dqa_generate&wd=ICE%E9%85%8D%E7%BD%AE&rsv_pq=d1a1d2060000fcf7&oq=webrtc%20ice%E5%8D%A1%E5%9C%A8%E4%BA%86connectionchecking&rsv_t=d69aQ6BVZykF9rTGlxTjhJl2XQHOkXwTuihObstR0u2w4m9ZctlTcdV6aH9pXzccNHf4dRI0SwA&tn=58025142_4_oem_dg&ie=utf-8)包括[STUN服务器](https://www.baidu.com/s?sa=re_dqa_generate&wd=STUN%E6%9C%8D%E5%8A%A1%E5%99%A8&rsv_pq=d1a1d2060000fcf7&oq=webrtc%20ice%E5%8D%A1%E5%9C%A8%E4%BA%86connectionchecking&rsv_t=d69aQ6BVZykF9rTGlxTjhJl2XQHOkXwTuihObstR0u2w4m9ZctlTcdV6aH9pXzccNHf4dRI0SwA&tn=58025142_4_oem_dg&ie=utf-8)和[TURN服务器](https://www.baidu.com/s?sa=re_dqa_generate&wd=TURN%E6%9C%8D%E5%8A%A1%E5%99%A8&rsv_pq=d1a1d2060000fcf7&oq=webrtc%20ice%E5%8D%A1%E5%9C%A8%E4%BA%86connectionchecking&rsv_t=d69aQ6BVZykF9rTGlxTjhJl2XQHOkXwTuihObstR0u2w4m9ZctlTcdV6aH9pXzccNHf4dRI0SwA&tn=58025142_4_oem_dg&ie=utf-8)的信息，需要确保这些服务器的地址、端口、用户名和密码等配置正确。
5. ‌**监听连接状态**‌：通过监听[RTCPeerConnection](https://www.baidu.com/s?sa=re_dqa_generate&wd=RTCPeerConnection&rsv_pq=d1a1d2060000fcf7&oq=webrtc%20ice%E5%8D%A1%E5%9C%A8%E4%BA%86connectionchecking&rsv_t=d69aQ6BVZykF9rTGlxTjhJl2XQHOkXwTuihObstR0u2w4m9ZctlTcdV6aH9pXzccNHf4dRI0SwA&tn=58025142_4_oem_dg&ie=utf-8)的连接状态变化，可以及时发现并处理连接问题。
6. ‌**处理错误**‌：通过监听连接状态变化和错误信息，可以及时处理传输、信令服务器错误、获取媒体流错误和ICE候选地址获取错误等问题。

如果以上步骤都无法解决问题，可能需要更详细的调试信息来进一步分析问题所在。这可能涉及到查看[WebRTC API](https://www.baidu.com/s?sa=re_dqa_generate&wd=WebRTC%20API&rsv_pq=d1a1d2060000fcf7&oq=webrtc%20ice%E5%8D%A1%E5%9C%A8%E4%BA%86connectionchecking&rsv_t=d69aQ6BVZykF9rTGlxTjhJl2XQHOkXwTuihObstR0u2w4m9ZctlTcdV6aH9pXzccNHf4dRI0SwA&tn=58025142_4_oem_dg&ie=utf-8)的日志输出，或者使用网络抓包工具来分析网络通信过程，以找出导致ICE连接状态卡在"checking"状态的具体原因‌12。


webrtc IceConnectionChecking没有后续了

WebRTC中的`IceConnectionChecking`状态表示ICE（Interactive Connectivity Establishment）过程的开始阶段。如果`IceConnectionChecking`没有后续，可能是因为以下原因：

1. 网络问题：设备可能无法访问网络，或者网络配置不正确，导致无法发现候选地址。
    
2. 信令服务问题：信令服务器可能无法响应，或者通信中断。
    
3. 浏览器或插件问题：WebRTC支持可能被禁用或存在bug。
    
4. 防火墙或安全设置：可能阻止了WebRTC通信。
    
5. SDP交换失败：在创建offer/answer过程中，Session Description Protocol（SDP）交换失败或不兼容。
    

解决方法：

1. 检查网络连接，确保设备可以正常访问互联网。
    
2. 确保信令服务器正常运行，并且客户端能够与之正确通信。
    
3. 确认浏览器和WebRTC支持是启用的，并且是最新版本。
    
4. 检查防火墙和安全设置，确保WebRTC所需的端口和协议没有被阻塞。
    
5. 检查SDP交换是否正确，确保生成的SDP能够被正确解析和理解。
    

如果以上步骤无法解决问题，可以使用WebRTC的调试工具，如`pc.getStats()`来获取更详细的信息，帮助定位问题。


