module mockserviceui/go

go 1.15

require (
	// 不存在的依赖包，在下面改写
	bettersun/mockservice v0.0.0
	github.com/go-flutter-desktop/go-flutter v0.42.0
	github.com/pkg/errors v0.9.1
)

// 使用本地目录改写上方的依赖包
replace bettersun/mockservice => ./plugin/mockservice

// 使用本地目录改写./plugin/mockservice的go.mod的mockservice依赖
replace github.com/bettersun/mockservice => E:/develop/github.com/bettersun/mockservice
