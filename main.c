/*
 * Copyright (C) 2008, 2009, 2010 Kaspar Schleiser <kaspar@schleiser.de>
 * Copyright (C) 2013 INRIA
 * Copyright (C) 2013 Ludwig Knüpfer <ludwig.knuepfer@fu-berlin.de>
 *
 * This file is subject to the terms and conditions of the GNU Lesser
 * General Public License v2.1. See the file LICENSE in the top level
 * directory for more details.
 */

#include <stdbool.h>
#include <stdio.h>
#include <string.h>

#include "periph/gpio.h"
#include "periph/i2c.h"
#include "periph/spi.h"
#include "periph/uart.h"
#include "xtimer.h"

int main(void)
{
	const i2c_t i2c_dev = I2C_DEV(0);
	i2c_init(i2c_dev);

	const spi_t spi_dev = SPI_DEV(0);
	spi_init(spi_dev);
	spi_init_cs(spi_dev, SPI_CS_UNDEF);

	const uart_t uart_dev = UART_DEV(0);
	uart_init(uart_dev, 115200, NULL, NULL);

	const uint8_t data = 0b10111001;

	while (true) {
		i2c_acquire(i2c_dev);
		i2c_write_byte(i2c_dev, data >> 1, data, 0);
		i2c_release(i2c_dev);

		spi_acquire(spi_dev, SPI_CS_UNDEF, SPI_MODE_0, SPI_CLK_100KHZ);
		spi_transfer_byte(spi_dev, SPI_CS_UNDEF, false, data);
		spi_release(spi_dev);

		uart_write(uart_dev, &data, 1);

		xtimer_msleep(100);
	}

	return 0;
}
