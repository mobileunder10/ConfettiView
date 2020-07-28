import SwiftUI

public enum ConfettiType {
  case diamond
  case rect
  case star
  case triangle
  
  var imageName: String {
    switch self {
    case .diamond:
      return "confetti_diamond"
    case .rect:
      return "confetti_rect"
    case .star:
      return "confetti_star"
    case .triangle:
      return "confetti_triangle"
    }
  }
}

public struct ConfettiView: UIViewRepresentable {
  
  let type: ConfettiType
  
  public init(type: ConfettiType = .rect) {
    self.type = type
  }
  
  public func makeUIView(context: Context) -> UIView {
    let size = CGSize(width: 824.0, height: 1112.0)
    let view = UIView(frame: CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height))
    
    let emitterLayer = CAEmitterLayer()
    emitterLayer.frame = CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height)
    
    view.layer.addSublayer(emitterLayer)
    view.layer.masksToBounds = true
    
    emitterLayer.emitterShape = .line
    emitterLayer.emitterPosition = CGPoint(x: view.frame.midX, y: 0)
    emitterLayer.emitterSize = CGSize(width: view.frame.size.width, height: 1)
    emitterLayer.seed = UInt32(Date().timeIntervalSince1970)
    
    var cells = [CAEmitterCell]()
    colors.forEach {
      cells.append(makeEmitterCell(color: $0))
    }
    
    emitterLayer.emitterCells = cells
    return view
  }
  
  func makeEmitterCell(color: UIColor) -> CAEmitterCell {
    let cell = CAEmitterCell()
    cell.contents = UIImage(named: type.imageName, in: .module, with: nil)?.cgImage
    cell.color = color.cgColor
    cell.birthRate = 40.0
    cell.lifetime = 20.0
    cell.lifetimeRange = 0.0
    cell.velocity = 20.0
    cell.velocityRange = 600.0
    cell.redRange = 1.0
    cell.greenRange = 1.0
    cell.blueRange = 1.0
    cell.alphaRange = 0.0
    cell.redSpeed = 0.0
    cell.greenSpeed = 0.0
    cell.blueSpeed = 0.0
    cell.alphaSpeed = -0.5
    cell.scaleSpeed = 0.1
    cell.spin = 2.0
    cell.spinRange = 8.0
    cell.emissionRange = .pi / 2
    cell.emissionLongitude = .pi
    
    return cell
  }
  
  public func updateUIView(_ uiView: UIView, context: Context) {
  }
  
  var colors: [UIColor] {
    [UIColor(Color(#colorLiteral(red: 0.94417274, green: 0.316423595, blue: 0.2223182619, alpha: 1))),
     UIColor(Color(#colorLiteral(red: 0.002248707693, green: 0.6354799271, blue: 1, alpha: 1))),
     UIColor(Color(#colorLiteral(red: 0.1156672761, green: 0.6930303574, blue: 0, alpha: 1))),
     UIColor(Color(#colorLiteral(red: 0.9705914855, green: 0.730086267, blue: 0.0003683686955, alpha: 1))),
     UIColor(Color(#colorLiteral(red: 0.7966906428, green: 0.1597183645, blue: 0.4828222394, alpha: 1)))]
  }
}


struct ConfettiView_Previews: PreviewProvider {
  static var previews: some View {
    Color.white.overlay(ConfettiView())
  }
}
