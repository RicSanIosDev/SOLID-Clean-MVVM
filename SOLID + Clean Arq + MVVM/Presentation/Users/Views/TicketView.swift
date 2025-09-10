//
//  TicketView.swift
//  SOLID + Clean Arq + MVVM
//
//  Created by ricardo sanchez on 10/9/25.
//

import UIKit

final class TicketView: UIView {

    let cornerRadiusView: CGFloat = 8
    let containerWidth: CGFloat = 0.8
    let dashWidth: CGFloat = 1.0
    let paddingHeightInitial: CGFloat = 0.9
    let padding: CGFloat = 0.4

    var notchHeight: CGFloat = 16 {
        didSet {
            setNeedsDisplay()
        }
    }
    var dividerHeight: CGFloat = 2.0 {
        didSet {
            setNeedsDisplay()
        }
    }
    var bcolor: UIColor = .clear {
        didSet {
            setNeedsDisplay()
        }
    }
    var interiorColor: UIColor = .white {
        didSet {
            setNeedsDisplay()
        }
    }
    var dashColor: UIColor = .brown {
        didSet {
            setNeedsDisplay()
        }
    }
    var isLoading: Bool = false {
        didSet {
            setNeedsDisplay()
        }
    }
    var createMask: Bool = false {
        didSet {
            setNeedsDisplay()
        }
    }
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        guard let context = UIGraphicsGetCurrentContext() else { return }
        let ticketPath = createTicketShape()

        bcolor.setFill()
        dashColor.setStroke()

        context.setLineWidth(containerWidth)
        context.addPath(ticketPath.cgPath)
        context.drawPath(using: .fillStroke)

        if createMask {
            // dash
            context.saveGState()
            context.setLineWidth(dashWidth)
            dashColor.setStroke()
            context.setLineDash(phase: 0, lengths: [5, 5])
            context.move(to: CGPoint(x: notchHeight, y: bounds.height/dividerHeight))
            context.addLine(to: CGPoint(x: bounds.width - notchHeight, y: bounds.height/dividerHeight))
            context.strokePath()
            context.restoreGState()
        }
        if createMask {
            createMask(context: context)
        }
    }

    func createTicketShape() -> UIBezierPath {
        let path = UIBezierPath()

        let ticketWidth = self.bounds.width
        let ticketHeight = self.bounds.height

        let startPoint = CGPoint(x: cornerRadiusView, y: 0)
        path.move(to: startPoint)

        let topLineEndPoint = CGPoint(x: ticketWidth - cornerRadiusView, y: 0)
        path.addLine(to: topLineEndPoint)

        path.addArc(
            withCenter: CGPoint(x: ticketWidth - cornerRadiusView,
                                y: cornerRadiusView),
            radius: cornerRadiusView,
            startAngle: CGFloat(Double.pi/2 * 3),
            endAngle: 0, clockwise: true
        )

        let rightLineEndPoint = CGPoint(x: ticketWidth, y: ticketHeight/dividerHeight - notchHeight)
        path.addLine(to: rightLineEndPoint)

        path.addArc(
            withCenter: CGPoint( x: ticketWidth,
                                 y: ticketHeight/dividerHeight
                               ),
            radius: notchHeight,
            startAngle: CGFloat(Double.pi/2 * 3),
            endAngle: CGFloat(Double.pi/2),
            clockwise: false
        )

        let bottomLineEndPoint = CGPoint(x: ticketWidth, y: ticketHeight - cornerRadiusView )
        path.addLine(to: bottomLineEndPoint)

        path.addArc(
            withCenter: CGPoint(x: ticketWidth - cornerRadiusView,
                                y: ticketHeight - cornerRadiusView),
            radius: cornerRadiusView,
            startAngle: 0,
            endAngle: CGFloat(Double.pi/2),
            clockwise: true
        )

        path.addLine(to: CGPoint(x: cornerRadiusView, y: ticketHeight))

        path.addArc(
            withCenter: CGPoint(x: cornerRadiusView,
                                y: ticketHeight - cornerRadiusView),
            radius: cornerRadiusView,
            startAngle: CGFloat(Double.pi/2),
            endAngle: CGFloat(Double.pi),
            clockwise: true
        )

        path.addLine(to: CGPoint(x: 0, y: ticketHeight/dividerHeight + notchHeight))

        path.addArc(
            withCenter: CGPoint(x: 0,
                                y: ticketHeight/dividerHeight),
            radius: notchHeight, startAngle: CGFloat(Double.pi/2),
            endAngle: CGFloat(Double.pi/2 * 3),
            clockwise: false
        )

        path.addLine(to: CGPoint(x: 0, y: cornerRadiusView))

        path.addArc(
            withCenter: CGPoint(x: cornerRadiusView,
                                y: cornerRadiusView),
            radius: cornerRadiusView,
            startAngle: CGFloat(Double.pi),
            endAngle: CGFloat(Double.pi/2 * 3),
            clockwise: true
        )

        path.close()
        return path
    }

    func createMask(context: CGContext) {
        context.saveGState()
        interiorColor.setFill()
        let bottomPath = UIBezierPath()
        bottomPath.move(to: CGPoint(x: notchHeight + padding, y: bounds.height/dividerHeight + paddingHeightInitial))
        bottomPath.addLine(
            to: CGPoint(
                x: bounds.width - notchHeight - padding,
                y: bounds.height/dividerHeight + paddingHeightInitial
            ))
        bottomPath.addCurve(
            to: CGPoint(x: bounds.width - padding, y: bounds.height / dividerHeight + notchHeight + padding),
            controlPoint1: CGPoint(
                x: bounds.width - notchHeight - padding,
                y: bounds.height / dividerHeight + padding),
            controlPoint2: CGPoint(
                x: bounds.width - notchHeight - padding,
                y: bounds.height / dividerHeight + notchHeight + padding)
        )

        bottomPath.addLine(to: CGPoint(x: bounds.width - padding, y: bounds.height - cornerRadiusView))
        bottomPath.addArc(
            withCenter: CGPoint(x: bounds.width - cornerRadiusView - padding,
                                y: bounds.height - cornerRadiusView - padding),
            radius: cornerRadiusView,
            startAngle: 0,
            endAngle: CGFloat(Double.pi/2),
            clockwise: true
        )
        bottomPath.addLine(to: CGPoint(x: cornerRadiusView, y: bounds.height - padding))
        bottomPath.addArc(
            withCenter: CGPoint(x: cornerRadiusView + padding,
                                y: bounds.height - cornerRadiusView - padding),
            radius: cornerRadiusView,
            startAngle: CGFloat(Double.pi/2),
            endAngle: CGFloat(Double.pi),
            clockwise: true
        )
        bottomPath.addLine(to: CGPoint(x: padding, y: bounds.height / dividerHeight + notchHeight + padding))
        bottomPath.addCurve(
            to: CGPoint(x: notchHeight + padding, y: bounds.height / dividerHeight + padding),
            controlPoint1: CGPoint(x: padding, y: bounds.height / dividerHeight + notchHeight + padding),
            controlPoint2: CGPoint(x: notchHeight + padding, y: bounds.height / dividerHeight + notchHeight + padding)
        )

        bottomPath.close()
        context.addPath(bottomPath.cgPath)
        context.fillPath()
        context.restoreGState()
    }
}
