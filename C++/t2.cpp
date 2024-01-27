#include <iostream>

using namespace std;

int main()
{
    cout << "Hello World!" << endl;
    cout << "Nested for loop" << endl;

    for (int i = 0; i < 10; i++)
    {
        for (int j = 0; j < 5; j++)
        {
            cout << i * j << endl;
        }
    }

    cout << "While loop inside if condition" << endl;
    int k = 0;
    if (k < 5)
    {
        while (k < 10)
        {
            cout << k << endl;
            k++;
        }
    }

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