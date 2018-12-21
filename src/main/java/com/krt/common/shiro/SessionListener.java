package com.krt.common.shiro;

import org.apache.shiro.session.Session;

import java.util.concurrent.atomic.AtomicInteger;

/**
 * @author 殷帅
 * @version 1.0
 * @Description: session监听器
 * @date 2017年10月25日
 */
public class SessionListener implements org.apache.shiro.session.SessionListener {

	private final AtomicInteger sessionCount = new AtomicInteger(0);

	@Override
	public void onStart(Session session) {
		sessionCount.incrementAndGet();
	}

	@Override
	public void onStop(Session session) {
		sessionCount.decrementAndGet();
	}

	@Override
	public void onExpiration(Session session) {
		sessionCount.decrementAndGet();

	}

	public int getSessionCount() {
		return sessionCount.get();
	}

}
