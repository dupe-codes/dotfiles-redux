use anyhow::Result;

#[cfg(test)]
mod test {
    use super::*;

    #[test]
    fn my_test() {}

    #[test]
    fn my_test() -> Result<()> {}

    #[test]
    fn my_other_test() -> Result<()> {
        hello();
    }
}

