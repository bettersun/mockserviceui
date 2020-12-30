package mockservice

import (
	"log"

	"github.com/bettersun/mockservice"
	"github.com/go-flutter-desktop/go-flutter"
	"github.com/go-flutter-desktop/go-flutter/plugin"
)

// go-flutter插件需要声明包名和函数名
// dart代码中调用时需要指定相应的包名和函数名
const (
	channelName = "bettersun.go-flutter.plugin.mockservice"

	helo     = "hello"
	run      = "run"
	close    = "close"
	hostlist = "hostlist"
	infolist = "infolist"
)

/// 声明插件结构体
type MockServicePlugin struct{}

/// 指定为go-flutter插件
var _ flutter.Plugin = &MockServicePlugin{}

/// 初始化插件
func (MockServicePlugin) InitPlugin(messenger plugin.BinaryMessenger) error {
	channel := plugin.NewMethodChannel(messenger, channelName, plugin.StandardMethodCodec{})

	channel.HandleFunc(helo, helloFunc)
	channel.HandleFunc(run, runFunc)
	channel.HandleFunc(close, closeFunc)
	channel.HandleFunc(hostlist, hostListFunc)
	channel.HandleFunc(infolist, infoListFunc)

	return nil
}

/// Hello
func helloFunc(arguments interface{}) (reply interface{}, err error) {
	mockservice.ChanelHello()
	return nil, nil
}

/// 启动服务
func runFunc(arguments interface{}) (reply interface{}, err error) {
	mockservice.ChanelRunService()
	return nil, nil
}

/// 关闭服务
func closeFunc(arguments interface{}) (reply interface{}, err error) {
	mockservice.ChanelClose()
	return nil, nil
}

///
func hostListFunc(arguments interface{}) (reply interface{}, err error) {
	hostlist := mockservice.ChanelTargetHostList()
	log.Println("Go Plugin: hostListFunc()")
	log.Println(hostlist)
	return hostlist, nil
}

///
func infoListFunc(arguments interface{}) (reply interface{}, err error) {
	infolist := mockservice.ChanelMockServiceInfoList()
	log.Println("Go Plugin: infoListFunc()")
	log.Println(hostlist)
	return infolist, nil
}
