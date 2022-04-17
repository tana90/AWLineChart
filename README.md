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
            lineChart.gridWidth: CGFloat = 0.3
            lineChart.lineWidth: CGFloat = 3
            lineChart.sideSpace: CGFloat = 44
            lineChart.bottomSpace: CGFloat = 44
            lineChart.showVerticalGrid: Bool = true
            lineChart.showHorizontalGrid: Bool = true
            lineChart.showBottomLabels: Bool = true
            lineChart.showSideLabels: Bool = true
            lineChart.gridColor: UIColor = .gray
            lineChart.labelsColor: UIColor = .black
            lineChart.animationDuration: Float = 0.3
            lineChart.chartType = .curved
            return lineGraph
        }()
        
    var data: [LineGraphData] = [
        LineChartData(xValue: "Value 1", yValue: 0.4),
        LineChartData(xValue: "Value 2", yValue: 0.6),
        LineChartData(xValue: "Value 3", yValue: 0.7),
        LineChartData(xValue: "Value 4", yValue: 0.3),
        LineChartData(xValue: "Value 5", yValue: 0.2),
        LineChartData(xValue: "Value 6", yValue: 0.5)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lineChart.tintColor = .orange
        lineChart.dataSource = self
        lineChart.delegate = self
        lineChart.reloadData()
    }
}
    
// MARK: Data Source

extension <#Your View Controller#>: AWLineChartDataSource {

    func numberOfItems(in lineGraph: AWLineChart) -> Int { 
        return data.count 
    }
    
    func lineGraph(_ lineGraph: AWLineChart, xValueAt index: Int) -> String { 
        return data[index].xValue 
    }
    
    func lineGraph(_ lineGraph: AWLineChart, yValueAt index: Int) -> Double { 
        return data[index].yValue 
    }
    
    func numberOfVerticalLines(in lineGraph: AWLineChart) -> Int { 6 }
    
    func numberOfHorizontalLines(in lineGraph: AWLineChart) -> Int { 4 }
    
    func numberOfBottomLabels(in lineGraph: AWLineChart) -> Int { 6 }
    
    func numberOfSideLabels(in lineGrapg: AWLineChart) -> Int { 5 }
    
    func lineGraph(_ lineGraph: AWLineChart, verticalDashPatternAt index: Int) -> [NSNumber] { [] }
    
    func lineGraph(_ lineGraph: AWLineChart, horizontalDashPatternAt index: Int) -> [NSNumber] { [4.0, 18.0] }
}

// MARK: Delegate

extension <#Your View Controller#>: AWLineChartDelegate {
    
    func lineGraphDidStartRender(_ lineGraph: AWLineChart) {
        // Called when start rendering
    }
    
    func lineGraphDidFinishRender(_ lineGraph: AWLineChart) {
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
