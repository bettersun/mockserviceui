module github.com/bettersun/mockserviceui

go 1.15

require (
	github.com/bettersun/mockservice/channel v0.0.0
	github.com/go-flutter-desktop/go-flutter v0.42.0
	github.com/pkg/errors v0.9.1
)

// 使用本地目录改写依赖
replace github.com/bettersun/moist => ../../moist

replace github.com/bettersun/mockservice => ../../mockservice

replace github.com/bettersun/mockservice/channel => ../../mockservice/channel
