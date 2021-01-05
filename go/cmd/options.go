package main

import (
	"github.com/go-flutter-desktop/go-flutter"

	mockservicechannel "github.com/bettersun/mockservice/channel"
)

var options = []flutter.Option{
	flutter.WindowInitialDimensions(1200, 720),
	flutter.WindowDimensionLimits(800, 500, 1280, 800),

	// 添加插件
	flutter.AddPlugin(mockservicechannel.MockServicePlugin{}),
}
