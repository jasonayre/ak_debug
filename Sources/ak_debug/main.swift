import Foundation
import AudioKit
import SporthAudioKit
import SoundpipeAudioKit

class TimerHolder:NSObject {
    var timer : Timer?
    var conductor: StereoOperationConductor! = nil

    @objc
    func timerFired(_:Timer) {
      conductor.generator.parameter1 = conductor.generator.parameter1 + 100
      conductor.generator.parameter2 =  conductor.generator.parameter2 + 100

      conductor.generator.parameters.forEach { param in
        param.value = param.value + 100
        print(param.value)
      }

      conductor.frequency = conductor.frequency + 100

      print(conductor.generator.parameters)
      // conductor.operation = SporthAudioKit.Operation.sineWave(frequency: OperationParameter(conductor.frequency), amplitude: 2.2)
      print(conductor.generator.parameter1)
      print("fired")
    }
    override init() {
        super.init()
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self,
            selector: #selector(timerFired),
            userInfo: nil, repeats: true)
    }
}

class StereoOperationConductor {
    let engine = AudioEngine()
    let sp_code = "'sine' 1024 gen_sine"
    var oscillator = FMOscillator()
    var operation: SporthAudioKit.Operation! = nil
    var generator: OperationGenerator! = nil
    var amplitude: AUValue! = nil
    var frequency = 1.0

    init() {
      // operation = StereoOperation(sp_code)
      // generator = OperationGenerator(channelCount: 2) { _ in
      //   return [operation.left(), operation.right()]
      // }
      // print(operation)
      operation = SporthAudioKit.Operation.sineWave(frequency: 1.1, amplitude: 2.2)

      print(operation)


      generator = OperationGenerator(channelCount: 2) { _ in
        // let operation = Operation.sineWave(frequency: 440, amplitude: 2.2)
        print("running generator")
        // self.operation = SporthAudioKit.Operation.sineWave(frequency: 50.0, amplitude: 2.2)

        // self.operation = SporthAudioKit.Operation.sineWave(frequency: self.generator.parameter1, amplitude: self.generator.parameter2)
        return [operation, operation]
      }
      // generator = OperationGenerator(sporth: sp_code)
      // generator = OperationGenerator(operation: operation)
      engine.output = generator
    }

    func start() {
        do {
            try engine.start()
            generator.start()
            print("should have started")
        } catch let err {
            Log(err)
        }
    }

    func stop() {
        engine.stop()
    }
}

print("start")

let timerholder = TimerHolder()

let op = StereoOperationConductor()
timerholder.conductor = op
op.start()

RunLoop.current.run()
