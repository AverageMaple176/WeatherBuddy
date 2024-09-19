import Foundation

extension Date {
    func localDate(for timezone: TimeZone) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.timeZone = timezone
        return dateFormatter.string(from: self)
    }
    
    func localTime(for timezone: TimeZone) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        dateFormatter.timeZone = timezone
        return dateFormatter.string(from: self)
    }
    
    func localWeekday(for timezone: TimeZone) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E"
        dateFormatter.timeZone = timezone
        return dateFormatter.string(from: self)
    }
}
