-- vim:set ft=lua:

-- The following values describe the QEMU ECAM MMIO device on ARM sbsa-ref.
-- These values are related to the QEMU sources in hw/arm/sbsa-ref.c.

local hw = Io.system_bus()

Io.Dt.add_children(hw, function()
  -- System Memory Management Unit
  smmuv3 = Io.Hw.Iommu(function()
    Property.idx = 0;
  end);

  -- Interrupt Translation Service
  its = Io.Hw.Msi_controller(function()
    Property.idx = 0;
  end);

  pciec0 = Io.Hw.Ecam_pcie_bridge(function()
    -- QEMU: SBSA_PCIE_MMIO
    Property.regs_base    = 0x80000000
    Property.regs_size    = 0x70000000
    -- QEMU: SBSA_PCIE_ECAM
    Property.cfg_base     = 0xf0000000
    Property.cfg_size     = 0x10000000
    -- QEMU: SBSA_PCIE_MMIO
    Property.mmio_base    = 0x80000000
    Property.mmio_size    = 0x70000000
    -- QEMU: SBSA_PCIE_MMIO_HIGH
    Property.mmio_base_64 = 0x100000000
    Property.mmio_size_64 = 0xFF00000000

    Property.int_a        = 32 + 3
    Property.int_b        = 32 + 4
    Property.int_c        = 32 + 5
    Property.int_d        = 32 + 6

    Property.iommu_map    = { 0x0, smmuv3, 0x0, 0x20000 }
    Property.msi_map      = { 0x0, its, 0x0, 0x20000 }
  end)
end)
