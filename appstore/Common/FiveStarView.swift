
import SwiftUI


public struct FiveStarView: View {
    var rating: Float
    var color: Color
    var backgroundColor: Color


    public init(
        rating: Float,
        color: Color = .gray,
        backgroundColor: Color = .gray
    ) {
        self.rating = rating
        self.color = color
        self.backgroundColor = backgroundColor
    }


    public var body: some View {
        ZStack {
            BackgroundStars(backgroundColor)
            ForegroundStars(rating: rating, color: color)
        }
    }
}


struct RatingStar: View {
    var rating: CGFloat
    var color: Color
    var index: Int
    
    
    var maskRatio: CGFloat {
        let mask = rating - CGFloat(index)
        
        switch mask {
        case 1...: return 1
        case ..<0: return 0
        default: return mask
        }
    }


    init(rating: Float, color: Color, index: Int) {
        
        self.rating = CGFloat(Double(rating.description) ?? 0)
        self.color = color
        self.index = index
    }


    var body: some View {
        GeometryReader { star in
            StarImage()
                .foregroundColor(self.color)
                .mask(
                    Rectangle()
                        .size(
                            width: star.size.width * self.maskRatio,
                            height: star.size.height
                        )
                    
                )
        }
    }
}


private struct StarImage: View {


    var body: some View {
        Image(systemName: "star.fill")
            .resizable()
            .aspectRatio(contentMode: .fill)
    }
}
private struct StarImage_Backgound: View {


    var body: some View {
        Image(systemName: "star")
            .resizable()
            .aspectRatio(contentMode: .fill)
    }
}

private struct BackgroundStars: View {
    var color: Color


    init(_ color: Color) {
        self.color = color
    }


    var body: some View {
        HStack(spacing:3) {
            ForEach(0..<5) { _ in
                StarImage_Backgound()
            }
        }.foregroundColor(color)
    }
}


private struct ForegroundStars: View {
    var rating: Float
    var color: Color


    init(rating: Float, color: Color) {
        self.rating = rating
        self.color = color
    }


    var body: some View {
        HStack(spacing:3) {
            ForEach(0..<5) { index in
                RatingStar(
                    rating: self.rating,
                    color: self.color,
                    index: index
                )
            }
        }
    }
}


struct FiveStarView_Previews: PreviewProvider {


    static var previews: some View {
        HStack {
            Text("test")
            FiveStarView(rating: 4.5)
                .frame(minWidth: 1, idealWidth: 100, maxWidth: 150, minHeight: 1, idealHeight: 30, maxHeight: 50, alignment: .center)
                .previewDevice("iPhone 11")
        }
    }
}
