64-BIT_TIMER_IP

▪ Timer is an essential module for every chip.

▪ This is used to generate accurate timing interval or controlling the timing of various
operations within the circuit. Timer can be used in various application: pulse
generation, delay generation, event generation, PWM generation, Interrupt
generation ….

▪ In this project, a timer module is customized from CLINT module of industrial RISC-V
architecture. It is used to generate interrupt based on user settings.

▪ The spec of CLINT can be referred at:
https://chromitem-soc.readthedocs.io/en/latest/clint.html


The timer has following features:

▪ 64-bit counter up.

▪ 4KB register address space 

▪ Timer has APB slave to receive settings from master.

▪ Support byte access(write to individual byte or half-word).

▪ Support wait state and error handling when writing to register set in prohibit conditions.

▪ Support interrupt when timer reaches setting value.


![image](https://github.com/user-attachments/assets/3f86735b-6f0b-4c10-a73a-04e005c68ea2)

REGISTER SUMMARY 

![image](https://github.com/user-attachments/assets/521fdfa1-a107-46ec-bd99-ea32a9f6960b)

WAVEFORM 

- Counter if control mode

![image](https://github.com/user-attachments/assets/402d9981-b78c-4baf-b882-0917bbee7bb7)

- ... 

For more information and detailed content, please refer to the design specification. !!

COVERAGE

![image](https://github.com/user-attachments/assets/77925b8c-1d6e-4ca0-b50e-38eaa85489f2)

Tool used:

Questa Intel 

