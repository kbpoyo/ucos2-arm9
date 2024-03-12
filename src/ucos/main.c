#include "board/irq.h"
#include "board/timer.h"
#include "board/uart.h"
#include "board/gpio.h"
#include "ucos_ii.h"

OS_STK MainTaskStk[MAIN_TASK_STK_LEN];
OS_STK Task0Stk[TASK0_STK_LEN];
OS_STK Task1Stk[TASK0_STK_LEN];
OS_STK Task2Stk[TASK0_STK_LEN];
OS_STK Task3Stk[TASK0_STK_LEN];
OS_STK Task4Stk[TASK0_STK_LEN];
OS_STK Task5Stk[TASK0_STK_LEN];
OS_STK Task6Stk[TASK0_STK_LEN];
OS_STK Task7Stk[TASK0_STK_LEN];
OS_STK Task8Stk[TASK0_STK_LEN];
OS_STK Task9Stk[TASK0_STK_LEN];

int arr[10] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9};

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

  OSTaskCreate(Task0, &arr[0], &Task0Stk[TASK0_STK_LEN], TASK0_PRIO);
  OSTaskCreate(Task0, &arr[1], &Task1Stk[TASK0_STK_LEN], TASK0_PRIO + 1);
  OSTaskCreate(Task0, &arr[2], &Task2Stk[TASK0_STK_LEN], TASK0_PRIO + 2);
  OSTaskCreate(Task0, &arr[3], &Task3Stk[TASK0_STK_LEN], TASK0_PRIO + 3);
  OSTaskCreate(Task0, &arr[4], &Task4Stk[TASK0_STK_LEN], TASK0_PRIO + 4);
  OSTaskCreate(Task0, &arr[5], &Task5Stk[TASK0_STK_LEN], TASK0_PRIO + 5);
  OSTaskCreate(Task0, &arr[6], &Task6Stk[TASK0_STK_LEN], TASK0_PRIO + 6);
  OSTaskCreate(Task0, &arr[7], &Task7Stk[TASK0_STK_LEN], TASK0_PRIO + 7);
  OSTaskCreate(Task0, &arr[8], &Task8Stk[TASK0_STK_LEN], TASK0_PRIO + 8);
  OSTaskCreate(Task0, &arr[9], &Task9Stk[TASK0_STK_LEN], TASK0_PRIO + 9);
  OSStatInit();     // 初始化统计任务需要的参数

  int a = 10;

  while (1) {
    uart_printf("main task run\n");
    OSTimeDly(OS_TICKS_PER_SEC);
  }

  return;
}

void Task0(void *pdata) {
  while (1) {
    uart_printf("task %d run\n", *(int*)pdata);
    OSTimeDly(OS_TICKS_PER_SEC);
  }
  return;
}

// void Tmr_TickHandler(void) {}