/**
 * @file bitmap.h
 * @author kbpoyo (kbpoyo.com)
 * @brief  定义位图数据结构
 * @version 0.1
 * @date 2023-02-04
 *
 * @copyright Copyright (c) 2023
 *
 */

#ifndef BITMAP_H
#define BITMAP_H

#include "common/types.h"

/**
 * @brief  位图数据结构
 * @param bit_count 位图对象管理的内存的分页数量
 * @param bits 位图数组，记录某一页是否被分配
 */
typedef struct _bitmap_t {
  uint32_t bit_count;  // 位图管理的bit数量
  uint8_t *bits;       // 位图管理的内存空间起始地址
} bitmap_t;

void bitmap_init(bitmap_t *bitmap, uint8_t *bits, uint32_t count, int init_bit);
uint8_t bitmap_get_bit(bitmap_t *bitmap, int index);
void bitmap_set_bit(bitmap_t *bitmap, int index, uint32_t count, int bit);
int bitmap_is_set(bitmap_t *bitmap, int index);
int bitmap_alloc_nbits(bitmap_t *bitmap, int bit, uint32_t count);
int bitmap_alloc_nbits_align(bitmap_t *bitmap, int bit, uint32_t count,
                             int align);
uint32_t bitmap_byte_count(uint32_t bit_count);

#endif