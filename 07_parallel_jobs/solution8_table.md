# Solution: Exercise 8 — Expected Results

## Typical results (p = 0.85, 30 s of simulated work)

| CPUs (n) | Time (s) | Speedup S = t₁/tₙ | Ideal speedup | Efficiency E = S/n × 100% |
|----------|----------|-------------------|---------------|--------------------------|
| 1 | 30.0 | 1.0× | 1× | 100% |
| 2 | 17.6 | 1.7× | 2× | 85% |
| 4 | 10.9 | 2.8× | 4× | 69% |
| 8 | 7.7 | 3.9× | 8× | 49% |

Your times will vary slightly due to system load and scheduling jitter.

## Key observations

- Theoretical maximum speedup (Amdahl's Law, p = 0.85): `1 / (1 - 0.85) = 6.7×`
- At 8 CPUs we get only 3.9× — we are well below the theoretical ceiling
- Efficiency drops continuously: each additional CPU contributes less
- At 8 CPUs, efficiency is ~49% — over half of each CPU's time is wasted on the serial fraction

## With p = 0.95 (rerun using `amdahl -p 0.95`)

| CPUs (n) | Approx. speedup | Approx. efficiency |
|----------|----------------|-------------------|
| 1 | 1.0× | 100% |
| 2 | 1.9× | 95% |
| 4 | 3.6× | 90% |
| 8 | 6.1× | 76% |

Theoretical maximum: `1 / (1 - 0.95) = 20×`

## Efficiency formula

```
Efficiency E = (Speedup / n) × 100%
             = (t₁ / tₙ / n) × 100%
```

An efficiency below 50% means you are wasting more resources than you are using.
In practice, many HPC centres consider 70% or above as good parallel efficiency.
