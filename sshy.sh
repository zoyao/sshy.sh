#!/usr/bin/expect

set timeout -1
set cmd "Usage:cmd <user@host> <password> \[-p <port>\] \[-d <dir>\] \[-i\]"

if {$argc < 2} {
  puts $cmd
  exit 1
}

set url [lindex $argv 0]
set password [lindex $argv 1]
set port 22
set dir ""
set flag false

for {set i 2} {$i < $argc} {incr i} {
  switch [lindex $argv $i] {
    "-p" {
      incr i
      set port [lindex $argv $i]
    }
    "-d" {
      incr i
      set dir [lindex $argv $i]
    }
    "-i" {
      set flag true
    }
    default {
      puts $cmd
      exit 1
    }
  }
}

spawn ssh -p $port $url
expect {
  # 首次登陆
  -nocase "*(yes/no*)?" {
    send "yes\n"
    exp_continue
  }
  # 密码错误时直接退出，错误码 1
  -nocase "*try again*" {
    send_user "password error!\n"
    exit 1; 
  }
  # 输入密码
  -nocase "*password*" {
    send "$password\n"
    exp_continue
  }
  # 登陆成功
  "*]\[#$\]" {
    # -i自动切换到root用户
    if {$flag} {
      send "sudo -i\n"
      set flag false
      exp_continue
    }
    # -d自动切换到指定目录
    if {$dir != ""} {
      send "cd $dir\n"
    }
  }
}
interact
