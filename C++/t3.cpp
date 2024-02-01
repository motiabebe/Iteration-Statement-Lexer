#include <iostream>

using namespace std;

int main() {
    cout << "Hello World!" << endl;
    cout << "for loop" << endl;
    for

    for (int i = 0; i < 10; i++) 

    for (int i = 0; i < 10; i++) {
        cout << i << endl;
    }

    cout << "Nested for loop" << endl;

    for (int j = 0; j < 5; j++) 
    {
        cout << i * j << endl;
    }

    for (int i = 0; i < 10; i++) {
        for (int j = 0; j < 5; j++) 
        {
            for (int j = 0; j < 5; j++) 
                {
                    cout << i * j << endl;
                }
            cout << i * j << endl;
        }
    }

    cout << "While loop" << endl;
    int j = 0;

    while

    while (j < 10)

    while (j < 10) 
    {
        cout << j << endl;
        j++;
    }


    while (j < 10) {
        cout << j << endl;
        j++;
        
        while (j < 10) {
            cout << j << endl;
            j++;
                while (j < 10) {
                    cout << j << endl;
                    j++;
                }

        }
    }

      
    

    cout << "Do-while loop" << endl;
    int k = 0;
    do {
        cout << k << endl;
        k++;
    } while (k < 10);

    cout << "Do-while loop inside switch case" << endl;
    int l = 0;
    switch (l)
    {
        case 0:
            do
            {
                cout << l << endl;
                l++;
            } while (l < 10);
            break;
        default:
            break;
    }
    return 0;
}