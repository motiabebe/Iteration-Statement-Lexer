#include <iostream>

using namespace std;

int main() {
    cout << "Hello World!" << endl;
    cout << "for loop" << endl;

    for (int i = 0; i < 10; i++) 

    cout << "While loop" << endl;
    int j = 0;
    while (j < 10) {
        cout << j << endl;
        j++;
    }

    cout << "Do-while loop" << endl;
    int k = 0;
    do {
        cout << k << endl;
        k++;
    } while (k < 10);

    return 0;
}