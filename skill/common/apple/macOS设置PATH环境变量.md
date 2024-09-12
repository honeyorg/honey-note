 #mac 

单个用户生效的配置，修改～/.bash_profile文件

如果没特殊说明,设置PATH的语法都为：

export PATH=<PATH 1>:<PATH 2>:<PATH 3>:.....:<PATH N>:$PATH

需要注意的是，上面的设置默认使用bash，如果使用的是zsh，需要再做如下配置，来达到环境变量设置的永久生效。

修改~/.zshrc  
bash的配置文件是.bashrc,，zsh的配置文件是.zshrc，当你使用zsh作为默认shell工具的时候，它启动时并不会加载bash的这两个配置文件.bashrc和.bash_profile，而只会  
加载自己的配置文件.zshrc，为了让我们的配置文件生效，只能在.zshrc中添加上面的配置。