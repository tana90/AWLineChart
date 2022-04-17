//
//  AWBezierConfiguration.swift
//
//  Copyright 2022 TANA (Tudor Octavian Ana)
//
//  Redistribution and use in source and binary forms, with or without modification,
//  are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice,
//  this list of conditions and the following disclaimer.
//
//  2. Redistributions in binary form must reproduce the above copyright notice,
//  this list of conditions and the following disclaimer in the documentation and/or
//  other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
//  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
//  OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
//  IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
//  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
//  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
//  HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
//  OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
//  EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//

import UIKit

public struct AWBezierSegmentControlPoints {
    var firstControlPoint: CGPoint
    var secondControlPoint: CGPoint
}

final public class AWBezierConfiguration {

    var firstControlPoints: [CGPoint?] = []
    var secondControlPoints: [CGPoint?] = []

    public func configureControlPoints(data: [CGPoint]) -> [AWBezierSegmentControlPoints] {
        let segments = data.count - 1
        if segments == 1 {
            return [AWBezierSegmentControlPoints(firstControlPoint: data[0], secondControlPoint: data[1])]
        } else if segments > 1 {

            // Left hand side coefficients
            var adCoefficient = [CGFloat]()
            var dCoefficient = [CGFloat]()
            var bdCoefficient = [CGFloat]()
            var rhsArray = [CGPoint]()

            for index in 0..<segments {

                var rhsXValue: CGFloat = 0
                var rhsYValue: CGFloat = 0

                let point0 = data[index]
                let point3 = data[index + 1]

                if index == 0 {
                    bdCoefficient.append(0.0)
                    dCoefficient.append(2.0)
                    adCoefficient.append(1.0)

                    rhsXValue = point0.x + 2 * point3.x
                    rhsYValue = point0.y + 2 * point3.y

                } else if index == segments - 1 {
                    bdCoefficient.append(2.0)
                    dCoefficient.append(7.0)
                    adCoefficient.append(0.0)

                    rhsXValue = 8 * point0.x + point3.x
                    rhsYValue = 8 * point0.y + point3.y
                } else {
                    bdCoefficient.append(1.0)
                    dCoefficient.append(4.0)
                    adCoefficient.append(1.0)

                    rhsXValue = 4 * point0.x + 2 * point3.x
                    rhsYValue = 4 * point0.y + 2 * point3.y
                }

                rhsArray.append(CGPoint(x: rhsXValue, y: rhsYValue))
            }

            return thomas(coefficients: (bdCoefficient, dCoefficient, adCoefficient),
                          rhsArray: rhsArray,
                          segments: segments, data: data)
        }

        return []
    }

    fileprivate func thomas(coefficients: ([CGFloat], [CGFloat], [CGFloat]),
                            rhsArray: [CGPoint],
                            segments: Int,
                            data: [CGPoint]) -> [AWBezierSegmentControlPoints] {

        var controlPoints: [AWBezierSegmentControlPoints] = []
        var adCoefficient = coefficients.2
        let bdCoefficient = coefficients.0
        let dCoefficient = coefficients.1
        var rhsArray = rhsArray
        let segments = segments

        var solutionSet1 = [CGPoint?]()
        solutionSet1 = Array(repeating: nil, count: segments)

        // First segment
        adCoefficient[0] = adCoefficient[0] / dCoefficient[0]
        rhsArray[0].x = rhsArray[0].x / dCoefficient[0]
        rhsArray[0].y = rhsArray[0].y / dCoefficient[0]

        // Middle Elements
        if segments > 2 {
            for index in 1...segments - 2 {
                let rhsValueX = rhsArray[index].x
                let prevRhsValueX = rhsArray[index - 1].x

                let rhsValueY = rhsArray[index].y
                let prevRhsValueY = rhsArray[index - 1].y

                adCoefficient[index] = adCoefficient[index] / (dCoefficient[index] -
                                                               bdCoefficient[index] * adCoefficient[index - 1])

                let exp1x = (rhsValueX - (bdCoefficient[index]*prevRhsValueX))
                let exp1y = (rhsValueY - (bdCoefficient[index]*prevRhsValueY))
                let exp2 = (dCoefficient[index] - bdCoefficient[index] * adCoefficient[index-1])

                rhsArray[index].x = exp1x / exp2
                rhsArray[index].y = exp1y / exp2
            }
        }

        // Last Element
        let lastElementIndex = segments - 1
        let exp1 = (rhsArray[lastElementIndex].x -
                    bdCoefficient[lastElementIndex] * rhsArray[lastElementIndex - 1].x)
        let exp1y = (rhsArray[lastElementIndex].y -
                     bdCoefficient[lastElementIndex] * rhsArray[lastElementIndex - 1].y)
        let exp2 = (dCoefficient[lastElementIndex] -
                    bdCoefficient[lastElementIndex] * adCoefficient[lastElementIndex - 1])
        rhsArray[lastElementIndex].x = exp1 / exp2
        rhsArray[lastElementIndex].y = exp1y / exp2

        solutionSet1[lastElementIndex] = rhsArray[lastElementIndex]

        for index in (0..<lastElementIndex).reversed() {
            let controlPointX = rhsArray[index].x - (adCoefficient[index] * solutionSet1[index + 1]!.x)
            let controlPointY = rhsArray[index].y - (adCoefficient[index] * solutionSet1[index + 1]!.y)
            solutionSet1[index] = CGPoint(x: controlPointX, y: controlPointY)
        }

        firstControlPoints = solutionSet1

        for index in 0 ..< segments {
            if index == segments - 1 {
                let lastDataPoint = data[index + 1]
                guard let controlPoint1 = firstControlPoints[index] else { continue }
                let controlPoint2X = 0.5 * (lastDataPoint.x + controlPoint1.x)
                let controlPoint2y = 0.5 * (lastDataPoint.y + controlPoint1.y)
                let controlPoint2 = CGPoint(x: controlPoint2X, y: controlPoint2y)
                secondControlPoints.append(controlPoint2)
            } else {
                let dataPoint = data[index + 1]
                guard let controlPoint1 = firstControlPoints[index + 1] else { continue }
                let controlPoint2X = 2 * dataPoint.x - controlPoint1.x
                let controlPoint2Y = 2 * dataPoint.y - controlPoint1.y
                secondControlPoints.append(CGPoint(x: controlPoint2X, y: controlPoint2Y))
            }
        }

        for index in 0 ..< segments {
            guard let firstCP = firstControlPoints[index] else { continue }
            guard let secondCP = secondControlPoints[index] else { continue }
            let segmentControlPoint = AWBezierSegmentControlPoints(firstControlPoint: firstCP,
                                                                   secondControlPoint: secondCP)
            controlPoints.append(segmentControlPoint)
        }

        return controlPoints
    }
}
