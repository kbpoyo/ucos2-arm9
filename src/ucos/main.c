#include "board/irq.h"
#include "board/timer.h"
#include "board/uart.h"
#include "board/gpio.h"
#include "ucos_ii.h"

OS_STK MainTaskStk[MAIN_TASK_STK_LEN];
OS_STK Task0Stk[TASK0_STK_LEN];

void os_init() {


  gpio_init();
  uart_init(0);
  irq_init();
  timer_init(OS_TICKS_PER_SEC);

  OSInit();
  OSTimeSet(0);
  OSTaskCreate(MainTask, 0, &MainTaskStk[MAIN_TASK_STK_LEN],
               MAIN_TASK_PRIO);
  OSStart();

  return 0;
}

void MainTask(void *pdata) {

  OSTaskCreate(Task0, 0, &Task0Stk[TASK0_STK_LEN], TASK0_PRIO);
  OSStatInit();     // 初始化统计任务需要的参数

  int a = 10;

  while (1) {
    uart_printf("main task\n");
    OSTimeDly(OS_TICKS_PER_SEC);
  }

  return;
}

void Task0(void *pdata) {
  while (1) {
    uart_printf("task0\n");
    OSTimeDly(OS_TICKS_PER_SEC);
  }
  return;
}

// void Tmr_TickHandler(void) {}