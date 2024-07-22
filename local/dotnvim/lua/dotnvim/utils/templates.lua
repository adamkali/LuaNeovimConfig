local M = {}

M.dotnvim_api_controller_template = function (name, namespace)
    return [[
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace ]] .. namespace .. [[
{
    [Route("api/[controller]")]
    [ApiController]
    [Authorize]
    [ApiExplorerSettings(IgnoreApi = false)]
    public class ]] .. name .. [[: ControllerBase
    {
        public ]] .. name .. [[()
        {
        }       

        [HttpGet()]
        [Route('/')]
        [
            ProducesResponseType(StatusCodes.Status200OK,
            Type = typeof(String))
        ]
        public async Task<String>
        Get()
        {
            return Ok("Hello World")
        }
    }
}
]]
end

M.dotnvim_api_model_template = function (name, namespace)
    return [[
using System;

namespace ]] .. namespace .. [[
{
    public class ]] .. name .. [[
    {
        public ID Guid { get; set; }
        // Insert The rest of your columns
        // ...
    }
}
]]
end
return M
