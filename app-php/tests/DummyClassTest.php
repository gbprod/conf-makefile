<?php

namespace Tests\AppPhp;

use AppPhp\DummyClass;
use PHPUnit\Framework\TestCase;

class DummyClassTest extends TestCase
{
    public function testConstruct()
    {
        $class = new DummyClass();

        $this->assertInstanceOf(DummyClass::class, $class);
    }
}
