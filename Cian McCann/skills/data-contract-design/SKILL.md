---
name: data-contract-design
description: "Formal agreements between data producers and consumers with schema versioning."
triggers:
  - "data contract"
  - "schema design"
  - "schema agreement"
  - "data interface"
---

# Data Contract Design Skill

## Contract Structure

### Schema
- Field names, types, constraints
- Required vs optional fields
- Nullability rules (which fields can be null, what null means)
- Enum values (allowed values for categorical fields)

### Quality Guarantees
- Freshness: How often is data updated?
- Completeness: What % of rows must have non-null values per field?
- Uniqueness: Which fields must be unique?
- Accuracy: What validation rules apply?

### SLAs
- Update frequency (real-time, hourly, daily)
- Availability (99.9% uptime?)
- Latency (how long from event to data available?)

### Evolution Rules
- **Additive changes** (minor version): New optional columns, new enum values
- **Breaking changes** (major version): Column removal, type changes, rename
- Communication: How are consumers notified of changes?

## Validation Code
```python
def validate_contract(df, contract):
    errors = []
    for field in contract.required_fields:
        if field not in df.columns:
            errors.append(f"Missing required field: {field}")
    for field, max_null in contract.null_limits.items():
        if field in df.columns:
            null_ratio = df[field].null_count() / len(df)
            if null_ratio > max_null:
                errors.append(f"{field} null ratio {null_ratio:.2%} > {max_null:.2%}")
    return errors
```

## Versioning
Semantic versioning: MAJOR.MINOR.PATCH
- MAJOR: Breaking changes (column removed, type changed)
- MINOR: Additive changes (new optional column)
- PATCH: Documentation, metadata only
