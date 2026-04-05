package com.civicplatform.dto.request;

import com.civicplatform.enums.EventType;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class EventRequest {
    
    @NotBlank(message = "Title is required")
    private String title;
    
    @NotBlank(message = "Date is required")
    private String date;
    
    @NotNull(message = "Event type is required")
    private EventType type;
    
    @NotNull(message = "Max capacity is required")
    private Integer maxCapacity;
    
    private String description;
    
    private String location;
}
