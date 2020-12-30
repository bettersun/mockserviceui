package main

import (
	"github.com/go-flutter-desktop/go-flutter"

	// ../go/go.mod中引入的mockservice依赖包
	"bettersun/mockservice"
)

var options = []flutter.Option{
	flutter.WindowInitialDimensions(1200, 720),

	// 添加插件
	flutter.AddPlugin(mockservice.MockServicePlugin{}),
}
