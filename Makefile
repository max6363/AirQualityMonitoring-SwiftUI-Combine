documentation:
	@jazzy \
	--build-tool-arguments \
	-workspace,AirQualityMonitoring-SwiftUI-Combine.xcworkspace,-scheme,AirQualityMonitoring-SwiftUI-Combine \
	--theme apple \
	--output ./docs \
	--documentation=./*.md

	@rm -rf ./build
