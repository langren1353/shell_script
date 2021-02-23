#!/usr/bin/env bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

#=================================================
#	System Required: CentOS 6/7/8,Debian 8/9/10,ubuntu 16/18/19
#	Description: 锐速开机自启动 - 守护进程
#	Version: 1.0
#	Author: AC
#=================================================

Green_font_prefix="\033[32m" && Red_font_prefix="\033[31m" && Green_background_prefix="\033[42;37m" && Red_background_prefix="\033[41;37m" && Font_color_suffix="\033[0m"
Info="${Green_font_prefix}[信息]${Font_color_suffix}"
Error="${Red_font_prefix}[错误]${Font_color_suffix}"

check_sys(){
	if [[ -f /etc/redhat-release ]]; then
		release="centos"
	elif cat /etc/issue | grep -q -E -i "debian"; then
		release="debian"
	elif cat /etc/issue | grep -q -E -i "ubuntu"; then
		release="ubuntu"
	elif cat /etc/issue | grep -q -E -i "centos|red hat|redhat"; then
		release="centos"
	elif cat /proc/version | grep -q -E -i "debian"; then
		release="debian"
	elif cat /proc/version | grep -q -E -i "ubuntu"; then
		release="ubuntu"
	elif cat /proc/version | grep -q -E -i "centos|red hat|redhat"; then
		release="centos"
    fi
	bit=`uname -m`
}
Service_lotServer(){
	if [[ ${release} = "centos" ]]; then
		if ! wget --no-check-certificate https://github.com/langren1353/shell_script/raw/main/service/lotServer_centos -O /etc/init.d/lotServer; then
			echo -e "${Error} 锐速Service 管理脚本下载失败 !" && exit 1
		fi
		chmod +x /etc/init.d/lotServer
		chkconfig --add lotServer
		chkconfig lotServer on
	else
		if ! wget --no-check-certificate https://github.com/langren1353/shell_script/raw/main/service/lotServer_debian -O /etc/init.d/lotServer; then
			echo -e "${Error} 锐速Service 管理脚本下载失败 !" && exit 1
		fi
		chmod +x /etc/init.d/lotServer
		update-rc.d -f lotServer defaults
	fi
	echo -e "${Info} 锐速Service 管理脚本下载完成 !"
	echo "可以试试重启之后是否会自动开启锐速"
}

check_sys
Service_lotServer