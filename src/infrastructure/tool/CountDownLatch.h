#ifndef COUNTDOWNLATCH_H
#define COUNTDOWNLATCH_H

#include <mutex>
#include <condition_variable>

class CountDownLatch
{
public:
  CountDownLatch(uint32_t count) : m_count(count){};
  void countDown() noexcept;
  void await() noexcept;

private:
  std::mutex m_mutex;
  std::condition_variable m_cv;
  uint32_t m_count;
};

#endif  // COUNTDOWNLATCH_H
