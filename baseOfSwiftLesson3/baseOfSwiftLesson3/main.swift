import Foundation

enum engine : String {
    case start = "Работает"
    case stop = "Остановлен"
}

enum windows : String {
    case open = "Открыто"
    case close = "Закрыто"
}

enum trunk : String {
    case putIn = "Положили в багажник"
    case takeOf = "Взяли из багажника"
}

enum typeOfCar : String {
    case passengerCar
    case track
}



struct Car {
    let brand : String
    let productionYear : Int
    let volumeOfTrunk : Int
    let typeOfCar : typeOfCar
    var engine : engine
    var windows : windows
    var currentVolumeOfTrunk : Int
    var conditioner : engine = .stop
    
    mutating func changeEngineState(_ moveKey: engine){
        if(moveKey != self.engine)
        {
            self.engine = moveKey
            print("Двигатель перешел в режим \(engine.rawValue)")
        }
        else
        {
            print("Двигатель уже в режиме \(engine.rawValue)!")
        }
        if(moveKey != .stop){
            self.conditioner = .stop
            print("Кондиционер в режиме \(engine.rawValue)!")
        }
    }
    
    mutating func changeWindowsState(_ moveTrank: windows){
        if(moveTrank != self.windows)
        {
            self.windows = moveTrank
            print("Окно \(windows.rawValue)")
        }
        else
        {
            print("Окно уже \(windows.rawValue)!")
        }
    }
    
    mutating func changeTrankState(trunk : trunk, volume : Int){
        guard volume >= 0 else {
            print("Отрицательное число? Не балуй - Это же килограммы! Введите пложительное число!")
            return
        }
        switch trunk {
        case .putIn:
            if((volume + currentVolumeOfTrunk) > volumeOfTrunk){
                print("Столько в багажник не влезет. Попробуйте на (\(volumeOfTrunk - currentVolumeOfTrunk - volume)) кг. меньше")
            } else {
                currentVolumeOfTrunk += volume
                print("Вы положили \(volume) кг. Теперь стало \(currentVolumeOfTrunk) кг.")
            }
        case .takeOf:
            if((currentVolumeOfTrunk - volume) < 0){
                print("Вы пытаетесь взять больше чем есть. Есть только \(currentVolumeOfTrunk) кг.")
            }else{
                currentVolumeOfTrunk -= volume
                print("Вы взяли \(volume) кг. Теперь осталось \(currentVolumeOfTrunk) кг.")
            }
        }
    }
    
    mutating func changeConditionState(_ moveKey : engine){
        if(moveKey != self.conditioner && self.engine == .start)
        {
            self.conditioner = moveKey
            print("Кондиционер перешел в режим \(conditioner.rawValue)")
        }
        else
        {
            print("Кондиционер в режиме \(conditioner.rawValue) или машина не заведена!")
        }
    }
    
    init(brand: String, productionYear: Int, volumeOfTrunk: Int, typeOfCar: typeOfCar){
        self.brand = brand
        self.productionYear = productionYear
        self.volumeOfTrunk = volumeOfTrunk
        self.typeOfCar = typeOfCar
        self.engine = .stop
        self.windows = .close
        self.currentVolumeOfTrunk = 0
    }
    
}

var passengerCar : Car = Car(brand: "Nissan Almera", productionYear: 2017, volumeOfTrunk: 450, typeOfCar: .passengerCar)

passengerCar.changeEngineState(.start)
passengerCar.changeWindowsState(.close)
passengerCar.changeTrankState(trunk: .putIn, volume: 1000)
print("")
var trackCar : Car = Car(brand: "Scania", productionYear: 2014, volumeOfTrunk: 25000, typeOfCar: .track)
trackCar.changeConditionState(.start)
trackCar.changeEngineState(.start)
trackCar.changeConditionState(.start)
trackCar.changeEngineState(.stop)
trackCar.changeTrankState(trunk: .putIn, volume: 1500)

