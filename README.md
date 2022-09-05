A description of this package.
# AWLineChart
## Simple - lightweight line chart
<a href="https://swift.org/package-manager/"><img src="https://img.shields.io/badge/SPM-supported-DE5C43.svg?style=flat"></a>

### How to use example

```swift

// MARK: Chart data model

struct LineChartData: AWLineChartData {
    var xValue: String
    var yValue: Double
}
    
class <#Your View Controller#>: UIViewController {

    lazy var lineChart: AWLineChart = {
        let lineChart = AWLineChart()
        lineChart.gridWidth = 0.3
        lineChart.lineWidth = 3
        lineChart.sideSpace = 44
        lineChart.bottomSpace = 44
        lineChart.showVerticalGrid = true
        lineChart.showHorizontalGrid = true
        lineChart.showBottomLabels = true
        lineChart.showSideLabels = true
        lineChart.gridColor = .gray
        lineChart.labelsColor = .black
        lineChart.animationDuration = 0.3
        lineChart.chartType = .curved
        lineChart.tintColor = .orange
        lineChart.dataSource = self
        lineChart.delegate = self
        return lineChart
    }()
        
    var data: [LineChartData] = [
        LineChartData(xValue: "Value 1", yValue: 0.4),
        LineChartData(xValue: "Value 2", yValue: 0.6),
        LineChartData(xValue: "Value 3", yValue: 0.7),
        LineChartData(xValue: "Value 4", yValue: 0.3),
        LineChartData(xValue: "Value 5", yValue: 0.2),
        LineChartData(xValue: "Value 6", yValue: 0.5)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lineChart.reloadData()
    }
}
    
// MARK: Data Source

extension <#Your View Controller#>: AWLineChartDataSource {

    func numberOfItems(in lineChart: AWLineChart) -> Int { 
        return data.count 
    }
    
    func lineChart(_ lineChart: AWLineChart, xValueAt index: Int) -> String { 
        return data[index].xValue 
    }
    
    func lineChart(_ lineChart: AWLineChart, yValueAt index: Int) -> CGFloat {
        return data[index].yValue
    }
    
    func numberOfVerticalLines(in lineChart: AWLineChart) -> Int { 6 }
    
    func numberOfHorizontalLines(in lineChart: AWLineChart) -> Int { 4 }
    
    func numberOfBottomLabels(in lineChart: AWLineChart) -> Int { 6 }
    
    func numberOfSideLabels(in lineChart: AWLineChart) -> Int { 5 }
    
    func lineChart(_ lineChart: AWLineChart, verticalDashPatternAt index: Int) -> [NSNumber] { [] }
    
    func lineChart(_ lineChart: AWLineChart, horizontalDashPatternAt index: Int) -> [NSNumber] { [4.0, 18.0] }
}

// MARK: Delegate

extension <#Your View Controller#>: AWLineChartDelegate {
    func lineChartDidFailRender(_ lineChar: AWLineChart) {
        // Called when failed with rendering
    }
    
    func lineChartDidStartRender(_ lineChart: AWLineChart) {
        // Called when start rendering
    }
    
    func lineChartDidFinishRender(_ lineChart: AWLineChart) {
        // Called when finish rendering
    }
}
```

### Requirements

- iOS 12.0+
- Swift 5.0+

### How it looks
<p align="left">
<img src="https://github.com/tana90/AWLineChart/blob/master/example.png?raw=true" width="357"/>
</p>
