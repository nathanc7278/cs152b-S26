#include "xparameters.h"
#include "xuartlite.h"
#include "cnn.h"
#include "weights.h"

XUartLite uart;
signed char input_buf[784];

void uart_read(u8 *buf, int n) {
    int received = 0;
    while (received < n) {
        received += XUartLite_Recv(&uart, buf + received, n - received);
    }
}

int main() {
    XUartLite_Initialize(&uart, XPAR_UARTLITE_0_DEVICE_ID);
    u8 raw[784];

    while (1) {
        int m = 0;
        while (m < 4) {
            u8 b;
            uart_read(&b, 1);
            if (b == 0xFF) m++;
            else m = 0;
        }

        uart_read(raw, 784);
        for (int i = 0; i < 784; i++) {
            input_buf[i] = (signed char)((int)raw[i] - 128);
        }

        int digit = infer(input_buf);
        u8 result = (u8)digit;
        XUartLite_Send(&uart, &result, 1);
    }

    return 0;
}
