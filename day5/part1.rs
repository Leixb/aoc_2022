use std::io;
use std::io::BufRead;

fn add_to_stack(stacks: &mut Vec<Vec<char>>, i: usize, c: char) {
    let stack = stacks.get_mut(i).unwrap();
    stack.push(c);
}

fn main() {
    let mut crane_drawing = Vec::new();
    let stdin = io::stdin();

    loop {
        let mut buffer = String::new();
        stdin.read_line(&mut buffer).expect("Failed to read line");
        if buffer.trim() == "" {
            break;
        }
        crane_drawing.push(buffer.replace("\n", ""));
    }

    let last_line = crane_drawing.pop().unwrap();
    let n = last_line.trim().split("   ").count();

    let mut stacks = vec![vec![]; n];

    for line in crane_drawing.iter().rev() {
        line
            .replace(&['[',']'], " ")
            .split("   ")
            .enumerate().for_each(|(i, s)| {
                if let Some(c) = s.trim().chars().next() {
                    add_to_stack(&mut stacks, i, c);
                }
            });
    }

    for line in stdin.lock().lines() {
        // move 3 from 8 to 9
        let line = line.unwrap();
        let words = line.split(" ").collect::<Vec<&str>>();

        if words.len() != 6 {
            eprintln!("Invalid command");
            continue;
        }

        let qty = words[1].parse::<usize>().unwrap();
        let from = words[3].parse::<usize>().unwrap();
        let to = words[5].parse::<usize>().unwrap();

        let from_stack = stacks.get_mut(from - 1).unwrap();
        let mut buffer_stack = Vec::new();

        for _ in 0..qty {
            if let Some(c) = from_stack.pop() {
                buffer_stack.push(c);
            }
        }

        let to_stack = stacks.get_mut(to - 1).unwrap();
        to_stack.append(&mut buffer_stack);
    }

    stacks.iter().for_each(|s| {
       print!("{}", s.last().unwrap_or(&' '));
    });
    println!();

}
