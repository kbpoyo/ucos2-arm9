/*
*********************************************************************************************************
*                                              uC/OS-II
*                                        The Real-Time Kernel
*
*                    Copyright 1992-2021 Silicon Laboratories Inc.
*www.silabs.com
*
*                                 SPDX-License-Identifier: APACHE-2.0
*
*               This software is subject to an open source license and is
*distributed by Silicon Laboratories Inc. pursuant to the terms of the Apache
*License, Version 2.0 available at www.apache.org/licenses/LICENSE-2.0.
*
*********************************************************************************************************
*/

/*
*********************************************************************************************************
*
*                                               ARM9 Port
*
* Filename : os_cpu_c.c
* Version  : V2.93.01
*********************************************************************************************************
*/

#define OS_CPU_GLOBALS
#include <ucos_ii.h>

#define ARM_SVC_MODE (0x00000013L)

/*
*********************************************************************************************************
*                                       OS INITIALIZATION HOOK
*                                            (BEGINNING)
*
* Description: This function is called by OSInit() at the beginning of OSInit().
*
* Arguments  : none
*
* Note(s)    : 1) Interrupts should be disabled during this call.
*********************************************************************************************************
*/
#if OS_CPU_HOOKS_EN > 0 && OS_VERSION > 203
void OSInitHookBegin(void) { OSIntCtxSwFlag = 0; }
#endif

/*
*********************************************************************************************************
*                                       OS INITIALIZATION HOOK
*                                               (END)
*
* Description: This function is called by OSInit() at the end of OSInit().
*
* Arguments  : none
*
* Note(s)    : 1) Interrupts should be disabled during this call.
*********************************************************************************************************
*/
#if OS_CPU_HOOKS_EN > 0 && OS_VERSION > 203
void OSInitHookEnd(void) {}
#endif

/*
*********************************************************************************************************
*                                          TASK CREATION HOOK
*
* Description: This function is called when a task is created.
*
* Arguments  : ptcb   is a pointer to the task control block of the task being
*created.
*
* Note(s)    : 1) Interrupts are disabled during this call.
*********************************************************************************************************
*/
#if OS_CPU_HOOKS_EN > 0
void OSTaskCreateHook(OS_TCB *ptcb) {
  ptcb = ptcb; /* Prevent compiler warning */
}
#endif

/*
*********************************************************************************************************
*                                           TASK DELETION HOOK
*
* Description: This function is called when a task is deleted.
*
* Arguments  : ptcb   is a pointer to the task control block of the task being
*deleted.
*
* Note(s)    : 1) Interrupts are disabled during this call.
*********************************************************************************************************
*/
#if OS_CPU_HOOKS_EN > 0
void OSTaskDelHook(OS_TCB *ptcb) {
  ptcb = ptcb; /* Prevent compiler warning */
}
#endif

/*
*********************************************************************************************************
*                                             IDLE TASK HOOK
*
* Description: This function is called by the idle task.  This hook has been
*added to allow you to do such things as STOP the CPU to conserve power.
*
* Arguments  : none
*
* Note(s)    : 1) Interrupts are enabled during this call.
*********************************************************************************************************
*/
#if OS_CPU_HOOKS_EN > 0 && OS_VERSION >= 251
void OSTaskIdleHook(void) {}
#endif

/*
*********************************************************************************************************
*                                           STATISTIC TASK HOOK
*
* Description: This function is called every second by uC/OS-II's statistics
*task.  This allows your application to add functionality to the statistics
*task.
*
* Arguments  : none
*********************************************************************************************************
*/

#if OS_CPU_HOOKS_EN > 0
void OSTaskStatHook(void) {}
#endif

/*
*********************************************************************************************************
*                                        INITIALIZE A TASK'S STACK
*
* Description: This function is called by either OSTaskCreate() or
*OSTaskCreateExt() to initialize the stack frame of the task being created. This
*function is highly processor specific.
*
* Arguments  : task          is a pointer to the task code
*
*              p_arg         is a pointer to a user supplied data area that will
*be passed to the task when the task first executes.
*
*              ptos          is a pointer to the top of stack.  It is assumed
*that 'ptos' points to a 'free' entry on the task stack.  If OS_STK_GROWTH is
*set to 1 then 'ptos' will contain the HIGHEST valid address of the stack.
*Similarly, if OS_STK_GROWTH is set to 0, the 'ptos' will contains the LOWEST
*valid address of the stack.
*
*              opt           specifies options that can be used to alter the
*behavior of OSTaskStkInit(). (see uCOS_II.H for OS_TASK_OPT_???).
*
* Returns    : Always returns the location of the new top-of-stack' once the
*processor registers have been placed on the stack in the proper order.
*
* Note(s)    : 1) Interrupts are enabled when your task starts executing.
*              2) All tasks run in SVC mode.
*********************************************************************************************************
*/

OS_STK *OSTaskStkInit(void (*task)(void *pd), void *p_arg, OS_STK *ptos,
                      INT16U opt) {
  OS_STK *stk;

  opt = opt; //不使用opt，防止编译器警告
  stk = ptos;
  *(--stk) = (OS_STK)task;  // pc = task
  stk -= 13;                // r1-r12 = 0

  *stk = (OS_STK)p_arg;             // r0 = p_arg 任务传入参数
  *(--stk) = (OS_STK)ARM_SVC_MODE;  // cpsr = SVC mode

  return (stk);
}

/*
*********************************************************************************************************
*                                           TASK SWITCH HOOK
*
* Description: This function is called when a task switch is performed.  This
*allows you to perform other operations during a context switch.
*
* Arguments  : none
*
* Note(s)    : 1) Interrupts are disabled during this call.
*              2) It is assumed that the global pointer 'OSTCBHighRdy' points to
*the TCB of the task that will be 'switched in' (i.e. the highest priority task)
*and, 'OSTCBCur' points to the task being switched out (i.e. the preempted
*task).
*********************************************************************************************************
*/
#if (OS_CPU_HOOKS_EN > 0) && (OS_TASK_SW_HOOK_EN > 0)
void OSTaskSwHook(void) {}
#endif

/*
*********************************************************************************************************
*                                           OS_TCBInit() HOOK
*
* Description: This function is called by OS_TCBInit() after setting up most of
*the TCB.
*
* Arguments  : ptcb    is a pointer to the TCB of the task being created.
*
* Note(s)    : 1) Interrupts may or may not be ENABLED during this call.
*********************************************************************************************************
*/
#if OS_CPU_HOOKS_EN > 0 && OS_VERSION > 203
void OSTCBInitHook(OS_TCB *ptcb) {
  ptcb = ptcb; /* Prevent Compiler warning                 */
}
#endif

/*
*********************************************************************************************************
*                                               TICK HOOK
*
* Description: This function is called every tick.
*
* Arguments  : none
*
* Note(s)    : 1) Interrupts may or may not be ENABLED during this call.
*********************************************************************************************************
*/
#if (OS_CPU_HOOKS_EN > 0) && (OS_TIME_TICK_HOOK_EN > 0)
void OSTimeTickHook(void) {}
#endif

/*
*********************************************************************************************************
*                                         ARM SPECIFIC CODE
*********************************************************************************************************
*/

/*
*********************************************************************************************************
*                                   INTERRUPT LEVEL CONTEXT SWITCH
*
* Description : This function is called by the OSIntExit() to perform a context
*switch at the completion of an ISR.  However, instead of actually doing the
*context switch from within OSIntExit(), we simply set a flag (OSIntCtxSwFlag)
*and defer the actual context switch until the actual ISR completes (see
*OS_CPU_IRQ_ISR()).
*
* Arguments   : none
*********************************************************************************************************
*/

void OSIntCtxSw(void) {
  OSIntCtxSwFlag =
      OS_TRUE; /* Indicate that a context switch from ISR is needed  */
}

/*
*********************************************************************************************************
*                                   TASK RETURN HOOK (APPLICATION)
*
* Description: This function is called if a task accidentally returns.  In other
*words, a task should either be an infinite loop or delete itself when done.
*
* Arguments  : ptcb      is a pointer to the task control block of the task that
*is returning.
*
* Note(s)    : none
*********************************************************************************************************
*/

#if OS_CPU_HOOKS_EN > 0 && OS_VERSION >= 289
void OSTaskReturnHook(OS_TCB *ptcb) { (void)ptcb; }
#endif
