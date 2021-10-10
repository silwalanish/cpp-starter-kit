#include <gtest/gtest.h>

#include "Math.hpp"

namespace CppStarterKit
{

  TEST(MathTest, AddShouldSumTwoNumbers)
  {
    ASSERT_EQ(add(1, 2), 3);
    ASSERT_EQ(add(2, 2), 4);
    ASSERT_NE(add(1, 3), 3);
  }

  TEST(MathTest, AddShouldHandleNegativeNumbers)
  {
    ASSERT_EQ(add(-1, 2), 1);
    ASSERT_EQ(add(2, -2), 0);
    ASSERT_EQ(add(1, -3), -2);
    ASSERT_EQ(add(-1, -3), -4);
    ASSERT_NE(add(-1, -5), -2);
  }

}
