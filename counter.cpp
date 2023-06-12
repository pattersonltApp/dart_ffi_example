#include <chrono>
#include <thread>

int counter = 0;

extern "C" {

    int work() {
        std::this_thread::sleep_for(std::chrono::seconds(2));
        counter++;
        return counter;
    }
}
