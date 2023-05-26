#define bus0 2
#define bus1 3
#define bus2 4
#define bus3 5
#define bus4 6
#define bus5 7
#define bus6 8
#define bus7 9
#define bus8 10
#define bus9 11
#define bus10 12
#define bus11 13
#define bus12 14
#define bus13 15
#define bus14 16
#define bus15 17
#define bus_control 18

const PROGMEM word ROM[4096] {0x00};
word address;

void setup() {
  portMode(bus_control, INPUT); //0 on bus means read from memory
}

void loop() {

}