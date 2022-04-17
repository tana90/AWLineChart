A description of this package.
# AWLineChart
## Simple - lightweight line chart
<a href="https://swift.org/package-manager/"><img src="https://img.shields.io/badge/SPM-supported-DE5C43.svg?style=flat"></a>

### How to use

```swift
lazy var lineGraph: AWLineGraph = {
        let lineGraph = AWLineGraph()
        lineGraph.maxNumberOfEntries = 24
        lineGraph.showVerticalGrid = true
        lineGraph.labelsColor = .black 
        lineGraph.lineWidth = 2
        lineGraph.circleRadius = 4
        lineGraph.data = [
            AWLineGraphData(xValue: "Value 1", yValue: 0.4),
            AWLineGraphData(xValue: "Value 2", yValue: 0.6),
            AWLineGraphData(xValue: "Value 3", yValue: 0.7),
            AWLineGraphData(xValue: "Value 4", yValue: 0.3),
            AWLineGraphData(xValue: "Value 5", yValue: 0.2),
            AWLineGraphData(xValue: "Value 6", yValue: 0.5)
            ]
        return lineGraph
    }()
```

### Requirements

- iOS 12.0+
- Swift 5.0+

### How it looks
<p align="left">
<img src="https://github.com/tana90/AWLineChart/blob/master/example.png?raw=true" width="357"/>
</p>
