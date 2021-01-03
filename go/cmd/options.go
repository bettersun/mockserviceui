package main

import (
	"github.com/go-flutter-desktop/go-flutter"

	"github.com/bettersun/mockservice"
)

var options = []flutter.Option{
	flutter.WindowInitialDimensions(1200, 720),
	flutter.WindowDimensionLimits(800, 500, 1280, 800),

	// 添加插件
	flutter.AddPlugin(mockservice.MockServicePlugin{}),
}
