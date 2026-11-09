
import SwiftUI

struct ContentView: View {

    var body: some View {

        VStack(spacing: 0) {

            HStack {
                Text("My Plants 🌱")
                    .font(.title)
                    .bold()

                Spacer()
            }
            .padding()

            Divider()

            Spacer()

            Text("No reminders set yet...")
                .foregroundStyle(.gray)

            Spacer()
        }
        .background(Color.black.ignoresSafeArea())
        .foregroundStyle(.white)
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}

