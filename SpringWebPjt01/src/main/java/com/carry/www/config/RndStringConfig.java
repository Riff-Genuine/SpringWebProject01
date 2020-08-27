package com.carry.www.config;

import java.util.UUID;

public class RndStringConfig {
	public static String getRndString() {
		return UUID.randomUUID().toString().replaceAll("-", "");
	}
}
