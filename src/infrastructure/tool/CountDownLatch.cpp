#include "CountDownLatch.h"

void CountDownLatch::countDown() noexcept
{
  std::lock_guard<std::mutex> guard(m_mutex);
  if (0 == m_count)
  {
    return;
  }
  --m_count;
  if (0 == m_count)
  {
    m_cv.notify_all();
  }
}

void CountDownLatch::await() noexcept
{
  std::unique_lock<std::mutex> lock(m_mutex);
  m_cv.wait(lock, [this] { return 0 == m_count; });
}
