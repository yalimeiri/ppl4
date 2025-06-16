//Q1
export function all<T>(promises : Array<Promise<T>>) : Promise<Array<T>> {

  return new Promise<T[]>((resolve, reject) => {
    if(promises.length === 0)
    {
      resolve([]);
      return;
    }

    const results: T[] = new Array(promises.length);
    let completedCount = 0;
    promises.forEach((promise, index) => {
      promise.then((result) => {
        results[index] = result;
        completedCount++;

        if(completedCount === promises.length)
        {
          resolve(results);
        }
      }).catch((error) => {
        reject(error);
      })
    });
  });
}

  
// Q2
export function* Fib1() {
  let prev = 0;
  let curr = 1;
  
  while (true) {
    yield curr;
    [prev, curr] = [curr, prev + curr];
  }
}

export function* Fib2() {
  const phi = (1 + Math.sqrt(5)) / 2;  // golden ratio
  const sqrt5 = Math.sqrt(5);
  let n = 1;
  
  while (true) {
    const fib = Math.round((Math.pow(phi, n) - Math.pow(-phi, -n)) / sqrt5);
    yield fib;
    n++;
  }
}
