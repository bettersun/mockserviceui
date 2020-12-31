module github.com/bettersun/mockserviceui

go 1.15

require (
	github.com/bettersun/mockservice v0.0.0-20201230131655-f4499aa8a772
	github.com/go-flutter-desktop/go-flutter v0.42.0
	github.com/pkg/errors v0.9.1
)

// 使用本地目录改写go.mod的mockservice依赖
replace github.com/bettersun/mockservice => ../../mockservice
