package main

import (
	"github.com/go-flutter-desktop/go-flutter"

	"github.com/bettersun/mockservice"
)

var options = []flutter.Option{
	flutter.WindowInitialDimensions(1200, 720),

	// 添加插件
	flutter.AddPlugin(mockservice.MockServicePlugin{}),
}
