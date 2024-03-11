
#include "timer.h"

#include "common/os_config.h"
#include "common/types.h"
#include "irq.h"
#include "tools/assert.h"


extern void OSTimeTick(void);

/**
 * @brief 定时器中断处理函数
 *
 */
static void irq_handler_for_timer4() {
  // ASSERT((rINTOFFSET == INT_TIMER4));
  // 清除中断
  irq_clear(INT_TIMER4, NOSUBINT);

  OSTimeTick();
}

/**
 * @brief 定时器初始化，使用定时器4作为系统内核定时器
 *
 */
void timer_init(uint32_t ticks_per_sec) {
  rTCFG0 = rTCFG0_INIT;
  rTCFG1 = rTCGG1_INIT;

  // 先关闭一下定时器,调试用
  rTCON = 0x0;

  // 设置定时器每一个时间片触发一次中断
  rTCNTB4 = (uint32_t)(1 * 1000 * 1000 / ticks_per_sec) / TIMER_RESOLVING_POWER;
  rTCON = HAND_REFLASH_4;  // 手动更新定时器4的计数器
  rTCON = AUTORELOAD_AND_START_4;  // 关闭手动更新位,设置自动重载并打开定时器4

  irq_handler_register(INT_TIMER4, irq_handler_for_timer4);
  irq_enable(INT_TIMER4, NOSUBINT);
}