import SwiftUI

struct Aircraft: Identifiable {
    var id = UUID()
    var name: String
    var hours: Double
}

struct ContentView: View {
    @State private var aircraftName = ""
    @State private var aircraftHours = ""
    @State private var aircrafts: [Aircraft] = []

    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("Add Aircraft")) {
                        TextField("Name", text: $aircraftName)
                        TextField("Current Hours", text: $aircraftHours)
                            .keyboardType(.decimalPad)
                        Button("Add") {
                            if let hours = Double(aircraftHours) {
                                let newAircraft = Aircraft(name: aircraftName, hours: hours)
                                aircrafts.append(newAircraft)
                                aircraftName = ""
                                aircraftHours = ""
                            }
                        }
                    }
                }
                List(aircrafts) { aircraft in
                    VStack(alignment: .leading) {
                        Text(aircraft.name).font(.headline)
                        Text("Current Hours: \(aircraft.hours, specifier: "%.1f")")
                        Text("Next 100 Hour Due: \(nextHundredHour(for: aircraft.hours), specifier: "%.1f")")
                            .foregroundColor(statusColor(for: aircraft.hours))
                    }
                }
            }
            .navigationBarTitle("Aircraft Tracker")
        }
    }

    private func nextHundredHour(for hours: Double) -> Double {
        let interval = floor(hours / 100) + 1
        return interval * 100
    }

    private func statusColor(for hours: Double) -> Color {
        let diff = nextHundredHour(for: hours) - hours
        if diff <= 0 {
            return .red
        } else if diff <= 10 {
            return .orange
        } else {
            return .green
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
