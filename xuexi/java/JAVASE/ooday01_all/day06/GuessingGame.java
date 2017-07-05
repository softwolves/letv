package day06;

import java.util.Scanner;

public class GuessingGame {
	public static void main(String[] args) {
		// 表示玩家猜测的次数
		int count = 0;
		// 用于保存判断的结果
		int[] result = new int[2];
		Scanner scanner = new Scanner(System.in);
		System.out.println("GuessingGame>欢迎尝试猜字母游戏！");
		// 表示猜测的字符串
		char[] chs = generate();
		System.out.println(chs);
		System.out.println("GuessingGame>游戏开始，请输入你所猜的5个字母序列：（exit——退出）");
		while (true) {
			String inputStr = scanner.next().trim().toUpperCase();
			if ("EXIT".equals(inputStr)) {
				System.out.println("GuessingGame>谢谢你的尝试，再见！");
				break;
			}

			char[] input = inputStr.toCharArray();
			result = check(chs, input);
			if (result[0] == chs.length) {// 完全猜对的情况
				int score = 100 * chs.length - count * 10;
				System.out.println("GuessingGame>恭喜你猜对了！你的得分是：" + score);
				break;
			} else {
				count++;
				System.out.println("GuessingGame>你猜对" + result[1] + "个字符，其中"
						+ result[0] + "个字符的位置正确！（总次数=" + count + "，exit——退出）");
			}
		}
		scanner.close();
	}

	/**
	 * 随机生成需要猜测的字母序列
	 * 
	 * @return 存储随机字符的数组
	 */
	public static char[] generate() {
		
		char[] letters = { 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J',
				'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V',
				'W', 'X', 'Y', 'Z' };
		boolean[] flags = new boolean[letters.length];
		char[] chs = new char[5];
		for (int i = 0; i < chs.length; i++) {
			int index;
			do {
				index = (int) (Math.random() * (letters.length));
			} while (flags[index]);// 判断生成的字符是否重复
			chs[i] = letters[index];
			flags[index] = true;
		}
		return chs;
	}

	/**
	 * 比较玩家输入的字母序列和程序所生成的字母序列，逐一比较字符及其位置，并记载比较结果
	 * 
	 * @param chs
	 *            程序生成的字符序列
	 * @param input
	 *            玩家输入的字符序列
	 * @return 存储比较的结果。返回值int数组 的长度为2，其中，索引为0的位置
	 *         用于存放完全猜对的字母个数(字符和位置均正确)，索引为1的位置用于存放猜对的字母个数(字符正确，但是位置不正确)。
	 */
	public static int[] check(char[] chs, char[] input) {
		int[] result = new int[2];
		for (int i = 0; i < input.length; i++) {
			for (int j = 0; j < chs.length; j++) {
				if (input[i] == chs[j]) {// 判断字符是否正确
					result[1]++;
					if (i == j) {// 判断位置是否正确
						result[0]++;
					}
					break;
				}
			}
		}
		return result;
	}
}
